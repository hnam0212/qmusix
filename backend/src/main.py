from flask import Flask

from .config import Config, DevConfig

# from framework.authentication import register_jwt_manager
from .framework.blueprints import register_blueprint
from .framework.cors import cors
from .framework.database import register_db
from .framework.error_handler import register_error_handlers


def create_app(config: Config = DevConfig):
    app = Flask(__name__)
    app.config.from_object(config)
    register_db(app)
    register_blueprint(app)
    cors(app)
    # register_jwt_manager(app)
    register_error_handlers(app)
    return app


# app = create_app(DevConfig)

# if __name__ == "__main__":
#     app.run()
