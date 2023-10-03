# Base image
FROM debian:11

# Update and install dependencies
RUN apt-get update && \
    apt-get install -y python3.9 python3-pip

# Set Python 3.9 as the default python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# Copy the application files into the container
COPY app app

# Expose port 5100 for the Flask app
EXPOSE 5100

# Command to run the Flask app
CMD ["python3", "app/__init__.py"]