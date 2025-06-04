FROM python:3.9-slim

# Install basic tools
RUN apt-get update && apt-get install -y \
    autoconf automake libtool \
    libpng-dev libjpeg-dev libtiff-dev zlib1g-dev \
    pkg-config wget curl git poppler-utils \
    build-essential \
    && apt-get clean

# Set work directory
WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy code
COPY . .

# Run _sys.py during build
RUN python _sys.py

# Expose the port
EXPOSE 8000

# Start the app
CMD ["python", "app.py"]
