from flask import Flask

from .config import Config, DevConfig

# from framework.authentication import register_jwt_manager
from .framework.blueprints import register_blueprints
from .framework.database import register_db


def create_app(config: Config = DevConfig):
    app = Flask(__name__)
    app.config.from_object(config)
    # app.config.SWAGGER_UI_DOC_EXPANSION = "list"
    register_db(app)
    register_blueprints(app)
    # register_jwt_manager(app)
    return app


# app = create_app(DevConfig)

# if __name__ == "__main__":
#     app.run()
