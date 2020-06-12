FROM ubuntu:18.04
RUN apt-get update -y &&\
	sudo apt -y install python3.7 &&\
	sudo apt update
RUN  sudo apt -y install python3-pip &&\
	sudo -H pip3 install --upgrade pip &&\
	sudo apt update
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
RUN python -m spacy download en_core_web_sm &&\
        python -m spacy download en_core_web_md
EXPOSE 5000
ENTRYPOINT [ "python" ]
CMD [ "run.py" ]
