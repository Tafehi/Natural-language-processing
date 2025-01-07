# Use an official Python runtime as a base image
FROM python:3.8-slim

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install TensorFlow and any other needed packages specified in requirements.txt
RUN pip install --no-cache-dir tensorflow && \
    pip install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME HuggingFaceApp

# Run the application
CMD ["python", "llm/your_script.py"]
