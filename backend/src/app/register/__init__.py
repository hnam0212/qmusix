from flask import Blueprint
from flask_restx import Api

from .routes import register_ns

register_bp = Blueprint("register", __name__, url_prefix="/api")
register_api = Api(register_bp)
register_api.add_namespace(register_ns)

# music_bp = Blueprint("music", __name__)
# authorizations = {"Bearer": {"type": "apiKey", "in": "header", "name": "Authorization"}}
# music_api = Api(music_bp, doc="/swagger-ui")
# music_api.add_namespace(music_ns)
