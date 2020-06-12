FROM python:alpine3.7 
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
RUN python -m spacy download en_core_web_sm &&\
	python -m spacy download en_core_web_md
EXPOSE 5000 
ENTRYPOINT [ "python" ] 
CMD [ "run.py" ]
