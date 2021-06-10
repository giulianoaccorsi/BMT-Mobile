from datetime import datetime, timedelta
from werkzeug.security import generate_password_hash, check_password_hash
from flask import current_app, url_for
from flask_login import UserMixin
from app import db, login
from time import time
import jwt
import os
import base64


class PaginatedAPIMixin(object):
    @staticmethod
    def to_collection_dict(query, page, per_page, endpoint, **kwargs):
        resources = query.paginate(page, per_page, False)
        data = {
            "items": [item.to_dict() for item in resources.items],
            "_meta": {
                "page": page,
                "per_page": per_page,
                "total_pages": resources.pages,
                "total_items": resources.total,
            },
            "_links": {
                "self": url_for(endpoint, page=page, per_page=per_page, **kwargs),
                "next": url_for(endpoint, page=page + 1, per_page=per_page, **kwargs)
                if resources.has_next
                else None,
                "prev": url_for(endpoint, page=page - 1, per_page=per_page, **kwargs)
                if resources.has_prev
                else None,
            },
        }
        return data


class User(UserMixin, PaginatedAPIMixin, db.Model):

    __tablename__ = "users"

    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(60), index=True, unique=True)
    password = db.Column(db.String(128))
    full_name = db.Column(db.String(60), index=True)
    email_confirmed = db.Column(db.Boolean, default=True)
    ad = db.relationship("Ad", backref="user", lazy="dynamic")
    token = db.Column(db.String(32), index=True, unique=True)
    token_expiration = db.Column(db.DateTime)
    created_at = db.Column(db.DateTime, default=datetime.utcnow())
    soft_deleted = db.Column(db.Boolean, default=False)

    def set_password(self, password):
        self.password = generate_password_hash(password)

    def verify_password(self, password):
        return check_password_hash(self.password, password)

    def get_token(self, expires_in=3600):
        now = datetime.utcnow()
        if self.token and self.token_expiration > now + timedelta(seconds=60):
            return self.token
        self.token = base64.b64encode(os.urandom(24)).decode("utf-8")
        self.token_expiration = now + timedelta(seconds=expires_in)
        db.session.add(self)
        return self.token

    def revoke_token(self):
        self.token_expiration = datetime.utcnow() - timedelta(seconds=1)

    def get_reset_password_token(self, expires_in=600):
        return jwt.encode(
            {"reset_password": self.id, "exp": time() + expires_in},
            current_app.config["SECRET_KEY"],
            algorithm="HS256",
        ).decode("utf-8")

    def get_confirm_email_token(self, expires_in=3600):
        return jwt.encode(
            {"confirm_email": self.id, "exp": time() + expires_in},
            current_app.config["SECRET_KEY"],
            algorithm="HS256",
        ).decode("utf-8")

    @staticmethod
    def check_token(token):
        user = User.query.filter_by(token=token).first()
        if user is None or user.token_expiration < datetime.utcnow():
            return None
        return user

    @staticmethod
    def verify_reset_password_token(token):
        try:
            jwt_id = jwt.decode(
                token, current_app.config["SECRET_KEY"], algorithms=["HS256"]
            )["reset_password"]
        except:
            return
        return User.query.get(jwt_id)

    @staticmethod
    def verify_confirm_email_token(token):
        try:
            jwt_id = jwt.decode(
                token, current_app.config["SECRET_KEY"], algorithms=["HS256"]
            )["confirm_email"]
        except:
            return
        return User.query.get(jwt_id)

    def __repr__(self):
        return "<User: {}>".format(self.id)

    def to_dict(self):
        data = {
            "id": self.id,
            "full_name": self.full_name,
            "email": self.email,
            "email_confirmed": self.email_confirmed,
        }
        return data

    def from_dict(self, data, new_user=False):
        for field in ["email", "full_name"]:
            if field in data:
                setattr(self, field, data[field])
        if new_user and "password" in data:
            self.set_password(data["password"])


@login.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


class Ad(PaginatedAPIMixin, db.Model):

    __tablename__ = "ads"

    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("users.id"))
    title = db.Column(db.String(60), index=True)
    description = db.Column(db.String(300))
    img_url = db.Column(db.String(300))
    created_at = db.Column(db.DateTime, default=datetime.utcnow())

    def __repr__(self):
        return "<Ad: {}>".format(self.id)

    def to_dict(self):
        data = {
            "id": self.id,
            "user_id": self.user_id,
            "title": self.title,
            "description": self.description,
            "img_url": self.img_url,
            "created_at": self.created_at,
        }
        return data

    def from_dict(self, data):
        for field in ["title", "description", "img_url"]:
            if field in data:
                setattr(self, field, data[field])
