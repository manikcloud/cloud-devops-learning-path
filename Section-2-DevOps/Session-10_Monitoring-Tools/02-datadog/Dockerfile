FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY simple-example.py app.py
COPY app.py .

EXPOSE 5001

CMD ["python", "simple-example.py"]
