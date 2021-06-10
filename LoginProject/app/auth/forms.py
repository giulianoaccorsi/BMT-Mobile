from flask_wtf import FlaskForm, RecaptchaField
from wtforms import (
    PasswordField,
    StringField,
    SubmitField,
    ValidationError,
    BooleanField,
)
from wtforms.validators import DataRequired, Email, EqualTo, Regexp

from password_validator import PasswordValidator

schema = PasswordValidator()

schema.min(8).max(
    16
).has().uppercase().has().lowercase().has().digits().has().no().spaces()
from app.models import User


class RegistrationForm(FlaskForm):
    full_name = StringField("Nome completo", validators=[DataRequired()])
    email = StringField("E-mail", validators=[DataRequired(), Email()])
    password = PasswordField(
        "Senha",
        validators=[
            DataRequired(),
            EqualTo("passwordc", message="As senhas não conferem!"),
        ],
    )
    passwordc = PasswordField("Confirme a senha")
    submit = SubmitField("Cadastrar")

    def validate_email(self, email):
        user = User.query.filter_by(email=email.data).first()
        if user:
            raise ValidationError("E-mail já utilizado! Escolha outro.")

    def validate_cpf(self, cpf):
        cpf_validator = CPF()
        if len(cpf.data) != 11:
            raise ValidationError("CPF inválido")
        new_cpf = (
            cpf.data[0:3]
            + "."
            + cpf.data[3:6]
            + "."
            + cpf.data[6:9]
            + "-"
            + cpf.data[9:11]
        )
        user = User.query.filter_by(cpf=cpf.data).first()
        if user:
            raise ValidationError("CPF já utilizado! Escolha outro.")
        elif not cpf_validator.validate(new_cpf):
            raise ValidationError("CPF inválido")

    def validate_password(self, password):
        if not schema.validate(password.data):
            raise ValidationError(
                "Sua senha deve conter: no mínimo 8 caracteres, no máximo 16 caracteres, dígitos, maiúsculas e não pode conter espaço!"
            )


class LoginForm(FlaskForm):
    emil = StringField("E-mail ou CPF", validators=[DataRequired()])
    password = PasswordField("Senha", validators=[DataRequired()])
    # recaptcha = RecaptchaField()
    submit = SubmitField("Login")


class ResetPasswordRequestForm(FlaskForm):
    email = StringField("E-mail ou CPF", validators=[DataRequired()])
    # recaptcha = RecaptchaField()
    submit = SubmitField("Enviar")


class ResendConfirmationEmail(FlaskForm):
    email = StringField("E-mail ou CPF", validators=[DataRequired()])
    # recaptcha = RecaptchaField()
    submit = SubmitField("Reenviar e-mail")


class ResetPasswordForm(FlaskForm):
    password = PasswordField("Senha", validators=[DataRequired()])
    password2 = PasswordField(
        "Repita a senha", validators=[DataRequired(), EqualTo("password")]
    )
    # recaptcha = RecaptchaField()
    submit = SubmitField("Resetar  senha")

    def validate_password(self, password):
        if not schema.validate(password.data):
            raise ValidationError(
                "Sua senha deve conter: no mínimo 8 caracteres, no máximo 16 caracteres, dígitos, maiúsculas e não pode conter espaço!"
            )