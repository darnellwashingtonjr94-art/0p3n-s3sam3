# Step 1: Base image for Python
FROM python:3.11-slim AS base
WORKDIR /app

# Step 2: Set environment variables to optimize Python inside Docker
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Step 3: Install system-level penetration testing tools (e.g., Nmap)
RUN apt-get update && apt-get install -y \
    nmap \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Step 4: Copy Python requirements and install them
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Step 5: Copy the rest of your repository's scripts and files
COPY . .

# Step 6: Default command (Opens a bash shell so you can run your tools)
CMD ["/bin/bash"]
