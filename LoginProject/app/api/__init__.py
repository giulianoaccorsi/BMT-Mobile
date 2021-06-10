from flask import Blueprint

api = Blueprint("api", __name__)

from . import errors, users, auth, tokens, email_confirmation, ads, reset_password
