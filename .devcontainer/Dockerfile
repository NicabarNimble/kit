# Patina YOLO Development Container
# Isolated Linux environment for safe LLM experimentation

FROM ubuntu:24.04

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install base utilities
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    vim \
    ca-certificates \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*



# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*





# Create workspace directory
WORKDIR /workspace

# Set up shell
CMD ["/bin/bash"]
