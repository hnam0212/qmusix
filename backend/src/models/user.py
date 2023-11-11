from datetime import datetime, timedelta
from uuid import uuid4

import jwt
from flask import current_app
from sqlalchemy.ext.hybrid import hybrid_property
from src.framework.database import db
from src.utils.datetime_util import ict_now
from werkzeug.security import check_password_hash, generate_password_hash


class User(db.Model):
    """User model for storing logon credentials and other details."""

    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    uuid = db.Column(db.String(36), unique=True, default=lambda: str(uuid4()))
    username = db.Column(db.String(64), unique=True, nullable=False)
    password_hash = db.Column(db.String(128), nullable=False)
    registered_on = db.Column(db.DateTime, default=ict_now)

    # def __repr__(self):
    #     attributes = ', '.join(f'{name}={value}' for name, value in vars(self).items())
    #     return f'{self.__class__.__name__}({attributes})'

    @property
    def password(self):
        raise AttributeError("Attempt to access write-only field")

    @password.setter
    def password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

    @classmethod
    def find_by_uuid(cls, uuid):
        return cls.query.filter_by(uuid=uuid).first()

    @classmethod
    def find_by_username(cls, username):
        return cls.query.filter_by(username=username).first()

    def encode_access_token(self):
        # now = ict_now()
        # token_age_h = current_app.config.get("TOKEN_EXPIRE_HOURS")
        # token_age_m = current_app.config.get("TOKEN_EXPIRE_MINUTES")
        # expire = now + timedelta(hours=token_age_h, minutes=token_age_m)
        payload = dict(sub=self.username)
        key = current_app.config.get("SECRET_KEY")
        return jwt.encode(payload, key, algorithm="HS256").encode("utf-8")

    @staticmethod
    def decode_access_token(access_token):
        if isinstance(access_token, bytes):
            access_token = access_token.decode("ascii")
        if access_token.startswith("Bearer "):
            split = access_token.split("Bearer")
            access_token = split[1].strip()
        try:
            key = current_app.config.get("SECRET_KEY")
            payload = jwt.decode(access_token, key, algorithms=["HS256"])
        # except jwt.ExpiredSignatureError:
        #     error = "Access token expired. Please log in again."
        #     return error
        except jwt.InvalidTokenError:
            error = "Invalid token. Please log in again."
            return None, error

        user_dict = dict(
            public_id=payload["sub"],
            token=access_token,
        )
        return user_dict
