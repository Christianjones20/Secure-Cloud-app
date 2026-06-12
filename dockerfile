FROM python:3.12-slim

WORKDIR /app

COPY app/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt 

COPY  app/ . 

EXPOSE 5000

RUN adduser --disabled-password --gecos "" appuser
USER appuser

CMD ["python", "app.py"]

