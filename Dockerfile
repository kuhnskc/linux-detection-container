FROM ubuntu:20.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive \
    HOME=/home/detector \
    USER_NAME=detector \
    USER_UID=1001

# Install required packages
RUN apt-get update && apt-get install -y \
    python3 \
    wget \
    curl \
    git \
    build-essential \
    cmake \
    libuv1-dev \
    libssl-dev \
    libhwloc-dev \
    && rm -rf /var/lib/apt/lists/*

# Create user with specific UID
RUN mkdir -p ${HOME} && \
    groupadd -r detector && \
    useradd -u ${USER_UID} -r -g detector -d ${HOME} -s /sbin/nologin -c "Detection user" detector && \
    chown -R ${USER_UID}:detector ${HOME} && \
    chmod -R g=u ${HOME}

# Set up work directory
WORKDIR ${HOME}/work

# Copy scripts
COPY --chown=${USER_UID}:detector scripts/ ${HOME}/work/scripts/

# Download and compile XMRig with verbose output
RUN git clone https://github.com/xmrig/xmrig.git && \
    cd xmrig && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make VERBOSE=1 && \
    chown -R ${USER_UID}:detector ${HOME}/work && \
    chmod -R g=u ${HOME}/work

# Set permissions
RUN chmod +x ${HOME}/work/scripts/run_tests.sh && \
    chown -R ${USER_UID}:detector ${HOME}/work && \
    chmod -R g=u ${HOME}/work

# Switch to non-root user
USER ${USER_UID}

# Run script
CMD ["/home/detector/work/scripts/run_tests.sh"]
