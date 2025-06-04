FROM python:3.9-slim

# Install system packages required to build tesserocr and related tools
RUN apt-get update && apt-get install -y \
    autoconf automake libtool \
    libpng-dev libjpeg-dev libtiff-dev zlib1g-dev \
    pkg-config wget curl git poppler-utils \
    build-essential \
    libtesseract-dev libleptonica-dev tesseract-ocr \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /app

# Copy all project files including app.py
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the app port
EXPOSE 8000

# Run the application
CMD ["python", "app.py"]
