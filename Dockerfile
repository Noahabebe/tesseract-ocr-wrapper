FROM python:3.9-slim

# Install system packages required for tesserocr, OpenCV, and poppler-utils
RUN apt-get update && apt-get install -y \
    autoconf automake libtool \
    libpng-dev libjpeg-dev libtiff-dev zlib1g-dev \
    pkg-config wget curl git poppler-utils \
    build-essential \
    libtesseract-dev libleptonica-dev tesseract-ocr \
    libgl1 libglib2.0-0 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Expose app port
EXPOSE 8000

# Run the app
CMD ["python", "app.py"]
