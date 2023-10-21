# Use an official Python runtime as a parent image
FROM python:3.7-slim

# Set the working directory in the container to /app
WORKDIR /app

# Run app.py when the container launches
# Removed duplicate CMD instruction

# Install any needed packages specified in requirements.txt, create a new user 'appuser' and install curl
RUN pip install --no-cache-dir -r requirements.txt && \
    adduser --disabled-password --gecos '' appuser && \
    apt-get update && apt-get install -y curl

# Use 'appuser' for running the container
USER appuser

# Add a healthcheck
HEALTHCHECK CMD curl --fail http://localhost:80/ || exit 1

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python", "app.py"]

# Install pipx
RUN /bin/sh -c python3 -m pip install --no-cache-dir --user pipx==0.16.0.0 &&  python3 -m pipx ensurepath && pipx install poetry==1.1.4
