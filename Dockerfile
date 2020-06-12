FROM alpine:3.7
RUN apt-get update -y &&\
	apt -y install python3.7 &&\
	apt update
RUN apt -y install python3-pip &&\
	pip3 install --upgrade pip &&\
	apt update
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
RUN python3 -m spacy download en_core_web_sm &&\
	python3 -m spacy download en_core_web_md
EXPOSE 5000
ENTRYPOINT [ "python3" ]
CMD [ "run.py" ]
