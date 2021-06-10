from flask import jsonify, request, g
from app.email import send_password_reset_email
from app.models import User
from app.api import api
from app.api.errors import bad_request
from datetime import datetime
from app import db

now = datetime.utcnow()


@api.post("/reset_password_request")
def password_request():
    data = request.get_json() or {}
    if "email" not in data:
        return bad_request("email is missing")
    user = User.query.filter_by(email=data["email"]).first()
    if user is None:
        return bad_request("email does not exist")
    g.current_user = user
    if user.token and not user.token_expiration < datetime.utcnow():
        return bad_request("User already logged in")
    send_password_reset_email(user)
    return jsonify({"message": "Email sent"})


@api.post("/verify_password_token")
def verify_password_change_request():
    data = request.get_json() or {}
    if "token" not in data or "password" not in data:
        return bad_request("Payload must contain token and password")
    user = User.verify_reset_password_token(data["token"])
    if user:
        user.set_password(data["password"])
        db.session.add(user)
        db.session.commit()
        return jsonify({"message": "Password changed"}), 200
    return bad_request("Token mismatch")
