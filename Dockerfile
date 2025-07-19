FROM ubuntu:20.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    build-essential \
    python3 \
    cmake \
    libuv1-dev \
    libssl-dev \
    libhwloc-dev \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m -s /bin/bash detector

# Create working directory
WORKDIR /home/detector/work

# Create scripts directory
RUN mkdir -p /home/detector/work/scripts

# Download and compile XMRig
RUN git clone https://github.com/xmrig/xmrig.git && \
    cd xmrig && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make

# Copy our test script
COPY scripts/run_tests.sh /home/detector/work/scripts/

# Set permissions
RUN chmod +x /home/detector/work/scripts/run_tests.sh && \
    chown -R detector:detector /home/detector/work

# Switch to non-root user
USER detector

# Run the test script directly
CMD ["/home/detector/work/scripts/run_tests.sh"]
