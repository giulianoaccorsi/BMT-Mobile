from flask import Flask
from config import Config
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_mail import Mail
from flask_cors import CORS
from flask_login import LoginManager

login = LoginManager()
login.login_message = "Você deve fazer login para acessar esta página"
login.login_view = "auth.login"
db = SQLAlchemy()
migrate = Migrate()
mail = Mail()



def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(config_class)
    db.init_app(app)
    migrate.init_app(app, db, render_as_batch=True)
    mail.init_app(app)
    login.init_app(app)
    CORS(app, resources={r"/api/*": {"origins": "*"}})

    from app.api import api as api_blueprint

    app.register_blueprint(api_blueprint, url_prefix="/api")

    from app.auth import auth as auth_blueprint

    app.register_blueprint(auth_blueprint)

    from app.main import main as main_blueprint

    app.register_blueprint(main_blueprint)

    from app import views, models

    return app
