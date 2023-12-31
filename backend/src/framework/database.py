from flask_migrate import Migrate
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


def register_db(app, db=db):
    db.init_app(app)
    migrate = Migrate(app, db)
    with app.app_context():
        db.create_all()
