from flask import jsonify, g
from app import db
from app.api import api
from app.api.auth import basic_auth, token_auth


@api.route("/tokens", methods=["POST"])
@basic_auth.login_required
def get_user_token():
    if g.current_user.email_confirmed:
        token = g.current_user.get_token()
        db.session.commit()
        return jsonify({"token": token})
    return jsonify({"message": "Confirm your email first"}), 403


@api.route("/tokens", methods=["DELETE"])
@token_auth.login_required
def revoke_token():
    g.current_user.revoke_token()
    db.session.commit()
    return "", 204
