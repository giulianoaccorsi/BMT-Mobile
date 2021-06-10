from flask import render_template, request, current_app, url_for, flash, redirect
from . import main
from flask_login import login_required
from app import db
from app.models import User


@main.route("/")
def index():
    return render_template("auth/login.html")


@main.route("/users", methods=["GET", "POST"])
@login_required
def homepage():

    page = request.args.get("page", 1, type=int)

    users = User.query.paginate(page, current_app.config["PAGINATION"], False)

    next_url = (
        url_for("main.homepage", page=users.next_num) if users.has_next else None
    )
    prev_url = (
        url_for("main.homepage", page=users.prev_num) if users.has_prev else None
    )

    return render_template(
        "main/users.html",
        users=users.items,
        title="Usuários",
        next_url=next_url,
        prev_url=prev_url,
        page=page,
        total_pages=1 if users.pages == 0 else users.pages,
    )


@main.route("/users/edit/<int:id>", methods=["GET", "POST"])
@login_required
def edit_user(id):
    user = User.query.get_or_404(id)
    if request.method == "POST":
        name = request.form["name"]
        email = request.form["email"]
        try:
            user.full_name = name
            user.email = email
            user.set_password(request.form["password"])
            db.session.commit()
            flash("Usuário editado com sucesso!", "success")
        except:
            db.session.rollback()
            flash("Falha na alteração do usuário", "error")
        finally:
            db.session.close()
            return redirect(url_for('main.homepage'))

    return render_template(
        "main/user.html",
        action="Edit",
        user=user,
        title="Editar usuário",
    )


@main.route("/users/delete/<int:id>", methods=["GET", "POST"])
@login_required
def delete_user(id):
    user = User.query.get_or_404(id)
    db.session.delete(user)
    db.session.commit()
    flash("Usuário deletada com sucesso!", "success")
    return redirect(url_for("main.homepage"))
