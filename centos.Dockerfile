ARG IMAGE_BASE="centos:8"
ARG IMAGE_USER="admin"

FROM ${IMAGE_BASE}

# Centos repo's
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN dnf update -y &&    \
    dnf upgrade -y &&   \
    dnf install -y      \
    git                 \
    vim                 \
    python3             \
    cmake               \
    gdb

ARG IMAGE_USER
RUN useradd -m -d "/home/${IMAGE_USER}" -s /bin/bash "${IMAGE_USER}"
