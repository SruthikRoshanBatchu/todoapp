FROM python:3.9-alpine

# Install necessary build dependencies (gcc, musl-dev, libffi-dev)
RUN apk add --no-cache --virtual .build-deps gcc musl-dev libffi-dev

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt /app/

# List the contents of the /app directory to verify the file is there
RUN ls -l /app

# Install virtualenv and dependencies from the requirements file
RUN pip install --upgrade pip && pip install -r requirements.txt

# Clean up build dependencies after installing packages
RUN apk del .build-deps

# Expose the port the app will run on
EXPOSE 8096

# Start the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8096"]
