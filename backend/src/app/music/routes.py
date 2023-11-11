from flask_restx import Namespace, Resource, fields
from src.models.music import Music

music_ns = Namespace(name="music")

music_model = music_ns.model(
    "Music",
    {"url": fields.String()},
)


@music_ns.route("/")
class MusicAPI(Resource):
    @music_ns.marshal_with(music_model)
    def get(self):
        return Music.query.all()


music_ns2 = Namespace(name="musictest")


@music_ns2.route("/")
class MusicAPI(Resource):
    @music_ns.marshal_with(music_model)
    def get(self):
        return Music.query.all()
