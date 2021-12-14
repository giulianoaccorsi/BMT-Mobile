from flask import redirect, url_for, flash
from flask_login import current_user
from functools import wraps


def admin_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        user = current_user.admin
        if not user:
            flash("Você deve ser admin para acessar este recurso", "error")
            return redirect(url_for("main.homepage"))
        return f(*args, **kwargs)

    return decorated