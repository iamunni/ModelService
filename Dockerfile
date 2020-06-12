FROM ubuntu:18.04
RUN apt-get update -y && \
   apt-get install -y python-pip python-dev
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
RUN python -m spacy download en_core_web_sm &&\
	python -m spacy download en_core_web_md
EXPOSE 5000 
ENTRYPOINT [ "python" ] 
CMD [ "run.py" ]
