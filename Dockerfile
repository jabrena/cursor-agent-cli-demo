# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install curl and other necessary packages
RUN apt-get update && \
    apt-get install -y curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install the Cursor CLI using the official installation script
RUN curl https://cursor.com/install -fsS | bash

# Add the installation directory to the system's PATH
ENV PATH="/root/.local/bin:${PATH}"

# Set the Cursor API key as an environment variable (should be provided at runtime)
# Example: docker run -e CURSOR_API_KEY=your_key_here
ENV CURSOR_API_KEY=""

# Verify the installation
RUN cursor-agent --version || true

# Set the default command
CMD ["cursor-agent", "--help"]

