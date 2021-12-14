from flask_wtf import FlaskForm, RecaptchaField
from wtforms import (
    PasswordField,
    StringField,
    SubmitField,
    ValidationError,
    BooleanField,
    FloatField
)
from wtforms.validators import DataRequired, Email


class AdForm(FlaskForm):
    top = BooleanField('Marque aqui se o anuncio é patrocinado')
    address = StringField('Endereço', validators=[DataRequired()])
    description = StringField('Descrição', validators=[DataRequired()])
    img_url = StringField('URL da imagem', validators=[DataRequired()])
    for_sale = BooleanField('Marqui aqui se o anuncio é de venda')
    price = FloatField('Preço', validators=[DataRequired()])
    city = StringField('Cidade', validators=[DataRequired()])
    district = StringField('Bairro', validators=[DataRequired()])
    state = StringField('Estado', validators=[DataRequired()])
    telephone = StringField('Telefone', validators=[DataRequired()])
    submit = SubmitField("Enviar")
