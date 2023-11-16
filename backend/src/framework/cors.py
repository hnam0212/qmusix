from flask_cors import CORS


def cors(app):
    CORS(app, resources={r"/api/v1/*": {"origins": "*"}})
