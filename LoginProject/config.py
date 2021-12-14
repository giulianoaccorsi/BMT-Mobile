import os

basedir = os.path.abspath(os.path.dirname(__file__))


class Config(object):
    SECRET_KEY = os.environ.get("SECRET_KEY") or "açaicombanana2019"
    SQLALCHEMY_DATABASE_URI = "postgresql://ktlvisphxildsd:534145898aeec47e197ec76fe646093a55ba90c7cbca106553afc8c5e2a6e34b@ec2-44-194-201-94.compute-1.amazonaws.com:5432/d9ie48htdib0o7"
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    PAGINATION = 99
    MAIL_SERVER = os.environ.get("MAIL_SERVER") or "smtp.gmail.com"
    MAIL_PORT = int(os.environ.get("MAIL_PORT") or 587)
    MAIL_USE_TLS = os.environ.get("MAIL_USE_TLS") or 1
    MAIL_USERNAME = (
        os.environ.get("MAIL_USERNAME") or "wadson.garbes.goncalves@gmail.com"
    )
    MAIL_PASSWORD = os.environ.get("MAIL_PASSWORD") or "saize123@456"
    ADMINS = ["giulianoaccorsi@gmail.com"]
