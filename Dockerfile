# syntax=docker/dockerfile:1
FROM python:latest
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
WORKDIR /flask
COPY requirements.txt /flask/requirements.txt
RUN pip install -r requirements.txt
# COPY . /flask/
EXPOSE 5000
COPY . .
CMD ["flask", "run"]