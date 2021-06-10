import os

basedir = os.path.abspath(os.path.dirname(__file__))


class Config(object):
    SECRET_KEY = os.environ.get("SECRET_KEY") or "açaicombanana2019"
    SQLALCHEMY_DATABASE_URI = os.environ.get(
        "DATABASE_URL"
    ) or "sqlite:///" + os.path.join(basedir, "app.db")
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    PAGINATION = 3
    MAIL_SERVER = os.environ.get("MAIL_SERVER") or "smtp.gmail.com"
    MAIL_PORT = int(os.environ.get("MAIL_PORT") or 587)
    MAIL_USE_TLS = os.environ.get("MAIL_USE_TLS") or 1
    MAIL_USERNAME = (
        os.environ.get("MAIL_USERNAME") or "wadson.garbes.goncalves@gmail.com"
    )
    MAIL_PASSWORD = os.environ.get("MAIL_PASSWORD") or "saize123@456"
    ADMINS = ["giulianoaccorsi@gmail.com"]
