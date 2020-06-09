from os import path
import spacy
from flask_restful import reqparse, abort, Resource
from flask import request
from nlp import app

MODEL_PATH = app.config['MODEL_PATH']

VERIFICATION_CODE = app.config['MAILBOT_VERIFICATION']


def abort_if_usecase_doesnt_exist(usecase_id):
    if path.exists(usecase_id):
        abort(404, message="Model doesn't exist for the usecase {}".format(usecase_id))


parser = reqparse.RequestParser()
parser.add_argument('usecase')
parser.add_argument('text')


class ModelView(Resource):

    def post(self):

        if not request.headers.get('VERIFICATION') == VERIFICATION_CODE:
            abort(400, message="Unauthorized")

        args = parser.parse_args()
        print(args)

        usecase_id = args.get('usecase', None)

        text = args.get('text', None)

        if not usecase_id:
            return {"Error": "usecase is required"}, 400
        if not text:
            return {"Error": "text is required"}, 400

        abort_if_usecase_doesnt_exist(usecase_id)

        model_path = "{}/usecases/{}".format(MODEL_PATH, usecase_id)

        try:
            usecase_model = spacy.load(model_path)
        except IOError:
            return {"Error": "Error in model loading"}, 400

        doc = usecase_model(text)

        entities = {}
        for ent in doc.ents:
            if ent.label_ in entities:
                entities[ent.label_].append({"text_org": ent.text, "text": ent.text.lower(), "start": ent.start_char,
                                             "end": ent.end_char})
            else:
                entities[ent.label_] = [{"text_org": ent.text, "text": ent.text.lower(), "start": ent.start_char,
                                         "end": ent.end_char}]

        print("**********************************")
        print("USECASE: ", usecase_id)
        print("PARSED DATA: ", entities)
        print("++++++++++++++++++++++++++++++++++")

        return entities
