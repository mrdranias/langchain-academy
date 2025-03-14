# Use Python 3.11 slim image for a lightweight container
FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    nano \
    net-tools \
    iputils-ping \
 && rm -rf /var/lib/apt/lists/*

# Set the working directory (matching the repository structure)
WORKDIR /home/app

# Copy all repository files into the container
COPY . /home/app

# Upgrade pip and install required Python dependencies plus Jupyter Notebook
RUN pip install --upgrade pip && \
    pip install -r requirements.txt jupyter

# Expose the Jupyter Notebook port
EXPOSE 8778

# Set default command to launch Jupyter Notebook without a token (for ease in local development)
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8778", "--allow-root", "--NotebookApp.token='t3st'"]
