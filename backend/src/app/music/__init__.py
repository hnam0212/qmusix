from flask import Blueprint
from flask_restx import Api

from .routes import music_ns, music_ns2

music_bp = Blueprint("music", __name__, url_prefix="/api")
authorizations = {"Bearer": {"type": "apiKey", "in": "header", "name": "Authorization"}}
music_api = Api(music_bp)
music_api.add_namespace(music_ns)

music_api.add_namespace(music_ns2)
