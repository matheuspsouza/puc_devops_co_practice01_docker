FROM python:3.11-slim

WORKDIR /app

# Copy the backend directory contents into the container
COPY backend/ .

# Install any necessary packages specified in requirements.txt
# Ensure you have a requirements.txt file in your backend directory
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port your backend app runs on (e.g., 5000)
EXPOSE 5000

# Define the command to run your application
CMD ["sh","./start-backend.sh"]