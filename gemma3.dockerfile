# Use Ubuntu 22.04 as base image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libcurl4-openssl-dev \
    curl \
    wget \
    zsh \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone llama.cpp repo
RUN git clone https://github.com/ggml-org/llama.cpp.git

WORKDIR /app/llama.cpp

# Configure and build llama-server
RUN cmake -B build -DLLAMA_SERVER=ON
RUN cmake --build build --config Release

# Expose port 8080 for llama-server
EXPOSE 8080

# Default command to run llama-server with hf model and token
CMD ["./build/bin/llama-server", "-hf", "unsloth/gemma-3-270m-it-GGUF", "--host", "0.0.0.0", "--port", "8080"]
