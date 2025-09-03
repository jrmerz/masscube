# Use Python 3.11 slim image as base
FROM python:3.11-slim

# Set maintainer information
LABEL maintainer="Huaxu Yu <yhxchem@outlook.com>"
LABEL description="Accurate and fast data processing for metabolomics"

# Install system dependencies needed for scientific packages
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY pyproject.toml ./
COPY src/ ./src/
COPY README.md ./
COPY LICENSE ./

# Install build tools and build the package from source
RUN pip install --no-cache-dir --upgrade pip build && \
    python -m build && \
    pip install --no-cache-dir dist/*.whl && \
    rm -rf dist/ build/ *.egg-info/

# Create a directory for data processing
RUN mkdir -p /data
WORKDIR /data

# Set the default command to show Python version and masscube info
CMD ["python", "-c", "import masscube; print('masscube containerized successfully'); print('Available commands: untargeted-metabolomics, batch-processing, generate-sample-table, find-outliers, build-classifier'); print('Use docker run --rm masscube:latest <command> to run specific commands'); print('Mount your data directory to /data for processing')"]