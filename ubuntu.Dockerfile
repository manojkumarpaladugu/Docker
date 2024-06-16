ARG IMAGE_BASE="ubuntu:22.04"
ARG IMAGE_USER="admin"

FROM ${IMAGE_BASE}

# Update system
RUN apt-get update      && \
    apt-get upgrade -y

RUN apt-get install -y \
    git                \
    vim                \
    python3            \
    cmake              \
    gdb

ARG DEBIAN_FRONTEND=noninteractive

ARG IMAGE_USER
RUN useradd -m -d "/home/${IMAGE_USER}" -s /bin/bash "${IMAGE_USER}"
