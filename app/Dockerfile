 FROM  python:3.11-slim
 
 WORKDIR /app
 COPY  src/  ./src
 RUN pip  install  flask  gunicorn
 
CMD  ["gunicorn",  "-b",  "0.0.0.0:8080",  "src.app:app"]
