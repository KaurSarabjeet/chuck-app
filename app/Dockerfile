# Dockerfile describing a container image for the Chuck Norris web application.
# Base image for the container
FROM alpine:3.20

# Install Python and dependencies
# Build time command
RUN apk add --no-cache python3 py3-pip libffi openssl curl

# Set working directory inside the container
WORKDIR /opt/app

# Copy the requirements file from one directory up because Dockerfile is inside app/
COPY requirements.txt .

# Create a Python virtual environment and install dependencies
# Build time command
RUN python3 -m venv /opt/venv && \
    source /opt/venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy the entire app source
COPY . .

# Set Python environment path
ENV PATH="/opt/venv/bin:$PATH"

# Expose Flask port
EXPOSE 5001

# Run the Flask app
# Container start command
CMD ["python", "main.py"]