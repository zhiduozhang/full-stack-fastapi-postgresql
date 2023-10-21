# Pull base image
FROM python:3.8-slim-buster

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /code

# Install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt /code/requirements.txt
RUN pip install -r requirements.txt

# Copy project
COPY . /code/

# Install poetry
RUN pip install poetry

# Configure poetry
RUN poetry config virtualenvs.create false && poetry install --no-interaction --no-ansi
USER appuser
HEALTHCHECK CMD ["python", "/code/healthcheck.py"]
