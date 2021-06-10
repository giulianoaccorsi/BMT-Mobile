from app.api.errors import bad_request
from flask import jsonify, request
from app import db
from app.models import User
from app.api import api


@api.route("/confirm_email", methods=["POST"])
def confirm_email():
    data = request.get_json()
    if data:
        token = data["token"]
        user = User.verify_confirm_email_token(token)
        if user:
            user.email_confirmed = True
            db.session.commit()
            return jsonify({"message": "Email confirmed"})
        else:
            return jsonify({"error": "User not found"})
        return bad_request("Invalid Token")
    return bad_request("Token is missing")
