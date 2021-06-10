from flask import flash, redirect, render_template, url_for, request
from flask_login import login_required, login_user, logout_user, current_user
from . import auth
from .forms import (
    ResetPasswordRequestForm,
    ResetPasswordForm,
)
from app import db
from app.models import User
from app.email import send_password_reset_email


@auth.route("/cadastrar", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        name = request.form["name"]
        email = request.form["email"]
        user = User.query.filter_by(email=email).first()
        if user:
            flash("Um usuário com este email já está cadastrado!", "error")
            return redirect(url_for("auth.login"))
        user = User(full_name=name, email=email)
        user.set_password(request.form["password"])
        db.session.add(user)
        db.session.commit()
        flash("Cadastro realizado com sucesso!", "success")
        return redirect(url_for("auth.login"))
    return render_template("auth/register.html", title="Cadastrar")


@auth.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form["email"]
        user = User.query.filter_by(email=email).first()
        if user and user.verify_password(request.form["password"]):
            login_user(user)
            return redirect(url_for("main.homepage"))
        else:
            flash("Usuário ou senha inválidos.", "error")
    return render_template("auth/login.html", title="Login")


@auth.route("/logout")
@login_required
def logout():
    logout_user()
    flash("Você saiu da sua conta!", "success")
    return redirect(url_for("auth.login"))


@auth.route("/request_new_password", methods=["GET", "POST"])
def reset_password_request():
    if current_user.is_authenticated:
        return redirect(url_for("main.homepage"))
    if request.method == "POST" and request.form["email"] is not None:
        user = User.query.filter_by(email=request.form['email']).first()
        if user:
            send_password_reset_email(user)
            flash("Verifique seu email para mais instruções sobre como resetar a senha!","success")
            return redirect(url_for("auth.login"))
        else:
            flash("Email não encontrado!", "error")
    return render_template(
        "auth/reset_password_request.html", title="Resetar senha")


@auth.route("/reset_password", methods=["GET", "POST"])
def reset_password():
    if current_user.is_authenticated:
        return redirect(url_for("main.homepage"))
    if request.method == "POST":
        user = User.verify_reset_password_token(request.form["token"])
        if not user:
            return redirect(url_for("main.homepage"))
        if request.method == "POST" and request.form["password"] != "":
            if request.form["password"] == request.form["password2"]:
                user.set_password(request.form["password"])
                db.session.commit()
                flash("Sua senha foi resetada.")
                return redirect(url_for("auth.login"))
            else:
                flash("As senhas não conferem", "error")
    return render_template("auth/reset_password.html")