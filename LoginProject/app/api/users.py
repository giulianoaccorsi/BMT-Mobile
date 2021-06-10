from flask import jsonify, request, url_for, g, abort
from datetime import timedelta
from app import db
from app.models import User
from app.api import api
from app.api.errors import bad_request
from app.api.auth import token_auth
from datetime import datetime
from app.email import send_password_reset_email, send_email_confirmation_token

now = datetime.utcnow()


@api.route("/reset_password_token", methods=["POST"])
def send_token():
    data = request.get_json()
    if not data:
        return bad_request("email is missing")
    user = User.query.filter_by(email=data["email"]).first()
    if user:
        if user.token_expiration and user.token_expiration > now + timedelta(
            seconds=60
        ):
            return jsonify({"error": "User already logged in"}), 403
        send_password_reset_email(user)
        return jsonify({"message": "email with token sent."})
    return jsonify({"error": "User not found"}), 403


@api.route("/reset_password", methods=["POST"])
def receive_token():
    data = request.get_json()
    if not data:
        return bad_request("token is missing")
    user = User.verify_reset_password_token(data["token"])
    if not user:
        return jsonify({"error": "token mismatch"})
    password = data["password"]
    user.set_password(password)
    db.session.commit()
    return jsonify({"message": "password reseted"})


@api.route("/users/<int:id>", methods=["GET"])
@token_auth.login_required
def get_user(id):
    if g.current_user.email_confirmed == True:
        if g.current_user.id != id:
            abort(403)
        return jsonify(User.query.get_or_404(id).to_dict())
    return jsonify({"message": "Confirm your email first"}), 403


@api.route("/users", methods=["GET"])
@token_auth.login_required
def get_users():
    if g.current_user.email_confirmed == True:
        page = request.args.get("page", 1, type=int)
        per_page = min(request.args.get("per_page", 10, type=int), 100)
        data = User.to_collection_dict(User.query, page, per_page, "api.get_users")
        return jsonify(data)
    return jsonify({"message": "Confirm your email first"}), 403


@api.route("/users", methods=["POST"])
def create_user():
    data = request.get_json() or {}
    if "email" not in data or "password" not in data:
        return bad_request("Must include full_name, email and password")
    if User.query.filter_by(email=data["email"]).first():
        return bad_request("email in use. Choose another one please!")
    user = User()
    user.from_dict(data, new_user=True)
    db.session.add(user)
    db.session.commit()
    # send_email_confirmation_token(user)
    response = jsonify(user.to_dict())
    response.status_code = 201
    response.headers["Location"] = url_for("api.get_user", id=user.id)
    return response


@api.route("/users/<int:id>", methods=["PUT"])
@token_auth.login_required
def update_user(id):
    if g.current_user.email_confirmed:
        if g.current_user.id != id:
            abort(403)
        user = User.query.get_or_404(id)
        data = request.get_json() or {}
        if (
            "email" in data
            and data["email"] != user.email
            and User.query.filter_by(email=data["email"]).first()
        ):
            return bad_request("Use outro email!")
        user.from_dict(data, new_user=False)
        db.session.commit()
        return jsonify(user.to_dict())
    return jsonify({"message": "Confirm your email first"}), 403
