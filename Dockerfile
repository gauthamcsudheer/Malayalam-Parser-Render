# Use the official Python image from the Docker Hub
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt /app/

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the working directory contents into the container at /app
COPY . /app/

# Run the collectstatic and migrate commands during build
RUN python manage.py collectstatic --noinput
RUN python manage.py migrate

# Command to run on container start
CMD ["gunicorn", "malayalam_parser_project.wsgi:application", "--bind", "0.0.0.0:8000"]
