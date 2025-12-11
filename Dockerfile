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

# Set the prompt parameter (should be provided at runtime)
# Example: docker run -e PROMPT="your prompt text here"
ENV PROMPT=""

# Verify the installation
RUN cursor-agent --version || true

# Set the default command to use the prompt parameter
# If PROMPT is provided, it will be passed to cursor-agent
CMD if [ -n "$PROMPT" ]; then cursor-agent "$PROMPT"; else cursor-agent --help; fi
