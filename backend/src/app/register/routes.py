from http import HTTPStatus

from flask import jsonify, request
from flask_restx import Namespace, Resource, abort, fields
from src.framework.database import db
from src.models.user import User

register_ns = Namespace(name="register_auth")


def process_registration_request(username, password):
    if User.find_by_username(username):
        abort(HTTPStatus.CONFLICT, f"{username} already registered")
    new_user = User(username=username, password=password)
    db.session.add(new_user)
    db.session.commit()
    access_token = new_user.encode_access_token()
    response = jsonify(
        status="success",
        message="successfully registered",
        access_token=access_token.decode(),
        token_type="bearer",
    )
    response.status_code = HTTPStatus.CREATED
    return response


register_schema = register_ns.model(
    "RegisterSchema",
    {
        "username": fields.String(required=True),
        "password": fields.String(required=True),
    },
)


@register_ns.route("/")
class Register(Resource):
    @register_ns.expect(register_schema)
    def post(self):
        username = register_ns.payload["username"]
        password = register_ns.payload["password"]
        return process_registration_request(username, password)

    @register_ns.expect(register_schema)
    def get(self):
        return {"message"}


# @register_ns.route("/test")
# class MusicAPI(Resource):
#     @register_ns.marshal_with(register_schema)
#     def get(self):
#         return User.query.all()
