FROM python:3.9-slim

# Install system packages required to build tesserocr
RUN apt-get update && apt-get install -y \
    autoconf automake libtool \
    libpng-dev libjpeg-dev libtiff-dev zlib1g-dev \
    pkg-config wget curl git poppler-utils \
    build-essential \
    libtesseract-dev libleptonica-dev tesseract-ocr \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /app

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Run _sys.py during build
RUN python _sys.py

# Expose the app port
EXPOSE 8000

# Run the application
CMD ["python", "app.py"]
