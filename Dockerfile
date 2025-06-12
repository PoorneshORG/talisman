# Use official Python base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy all files into the container
COPY . .

# Dummy requirements (won’t fail even if empty)
RUN pip install --no-cache-dir -r requirements.txt || true

# Run a dummy Python script (you can create `main.py`)
CMD ["python", "main.py"]
