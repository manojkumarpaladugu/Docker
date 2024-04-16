ARG IMAGE_BASE="ubuntu:22.04"
ARG WORKSPACE="/root/workspace"
ARG ARM_GCC_VERSION=10.3-2021.10
ARG ARM_GCC=gcc-arm-none-eabi-${ARM_GCC_VERSION}
ARG ARM_GCC_ARCHIVE=${ARM_GCC}-x86_64-linux.tar.bz2
ARG ARM_GCC_URL=https://developer.arm.com/-/media/Files/downloads/gnu-rm/${ARM_GCC_VERSION}/${ARM_GCC_ARCHIVE}

FROM ${IMAGE_BASE}

ARG WORKSPACE
WORKDIR ${WORKSPACE}

# Install packages
RUN apt-get update     && \
    apt-get upgrade -y && \
    apt-get install -y    \
    wget                  \
    git                   \
    vim                   \
    tar                   \
    bzip2                 \
    cmake                 \
    python3.10            \
    python3.10-venv       \
    python3-pip

RUN ln -s /usr/bin/python3 /usr/bin/python  && \
    pip install cmake --upgrade

# Install ARM GCC compiler
ARG ARM_GCC_URL
ARG ARM_GCC_ARCHIVE
RUN wget "${ARM_GCC_URL}"               && \
    tar xjf ${ARM_GCC_ARCHIVE} -C /opt  && \
    rm ${ARM_GCC_ARCHIVE}

# Add ARM GCC compiler to PATH variable
ARG ARM_GCC
ENV PATH="/opt/${ARM_GCC}/bin:${PATH}"
