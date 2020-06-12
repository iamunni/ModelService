FROM ubuntu:18.04
RUN apt-get update -y &&\
	apt -y install python3.7 &&\
	apt update
RUN apt -y install python3-pip &&\
	pip3 install --upgrade pip &&\
	apt update
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 5000
ENTRYPOINT [ "python" ]
CMD [ "run.py" ]
