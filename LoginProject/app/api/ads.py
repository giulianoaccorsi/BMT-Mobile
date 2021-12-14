from flask import jsonify, request, url_for, g
from app import db
from app.models import Ad
from app.api import api
from app.api.errors import bad_request
from app.api.auth import token_auth
from datetime import datetime
import os

basedir = os.path.abspath(os.path.dirname(__file__))

now = datetime.utcnow()


def contains_ads_parameters(data):
    if (
        "user_id" not in data
        and "title" not in data
        and "description" not in data
        and "img_url" not in data
        and "telophone" not in data
    ):
        return False
    return True


@api.get('/ads/<int:id>')
@token_auth.login_required
def get_especific_ad(id):
    if g.current_user.email_confirmed:
        return jsonify(Ad.query.get_or_404(id).to_dict())
    return jsonify({'message': "Confirm your email first"}), 403


@api.get("/ads")
@token_auth.login_required
def get_ads():
    if g.current_user.email_confirmed:
        page = request.args.get("page", 1, type=int)
        per_page = min(request.args.get("per_page", 10, type=int), 100)
        data = Ad.to_collection_dict(Ad.query, page, per_page, "api.get_ads")
        return jsonify(data)
    return jsonify({"message": "Confirm your email first"}), 403


@api.post("/ads")
@token_auth.login_required
def create_ad():
    data = request.get_json() or {}
    if not contains_ads_parameters(data):
        return bad_request("Must include title, descritption and img_url")
    ad = Ad(user_id=g.current_user.id)
    ad.from_dict(data)
    db.session.add(ad)
    db.session.commit()
    # send_email_confirmation_token(user)
    response = jsonify(ad.to_dict())
    response.status_code = 201
    response.headers["Location"] = url_for("api.get_user", id=ad.id)
    return response


@api.put("/ads/<int:id>")
@token_auth.login_required
def update_ad(id):
    if g.current_user.email_confirmed:
        ad = Ad.query.get_or_404(id)
        data = request.get_json() or {}
        ad.from_dict(data)
        db.session.commit()
        return jsonify(ad.to_dict())
    return jsonify({"message": "Confirm your email first"}), 403


@api.delete("/ads/<int:id>")
@token_auth.login_required()
def delete_ad(id):
    ad = Ad.query.get_or_404(id)
    db.session.delete(ad)
    db.session.commit()
    return jsonify({"message": "resource deleted"}), 202
