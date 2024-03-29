FROM ubuntu:18.04

MAINTAINER Arnaud Morin "arnaud.morin@gmail.com"

RUN apt-get update -y && \
    apt-get install -y python3-pip python3-dev

# We copy just the requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip3 install -r requirements.txt

COPY . /app

EXPOSE 8080

ENTRYPOINT [ "python3" ]

CMD [ "start.py" ]

