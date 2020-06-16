from nlp import api
from nlp.api import ModelView
from nlp.api import GetView

api.add_resource(ModelView, '/parse/')
api.add_resource(GetView, '/get/')
