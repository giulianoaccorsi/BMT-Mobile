import os
from app import create_app, db

from app.models import User

app = create_app()


if os.environ.get("FLASK_ENV") == "development":
    if __name__ == "__main__":
        app.run()

@app.shell_context_processor
def make_shell_context():
    return {"db": db, "User": User}
