ARG IMAGE_BASE="ubuntu:24.04"

FROM ${IMAGE_BASE}

# Update system
RUN apt-get update     && \
    apt-get upgrade -y

ARG MYHOME=/root
ENV MYHOME ${MYHOME}
ARG PYTHONVER=3.6
ENV PYTHONVER ${PYTHONVER}
ARG PYTHONNAME=py${PYTHONVER}
ENV PYTHONNAME ${PYTHONNAME}
ARG DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get install -y sudo locales wget git curl zip vim apt-transport-https tzdata language-pack-nb language-pack-nb-base manpages \
    build-essential libjpeg-dev libssl-dev xvfb zlib1g-dev libbz2-dev libreadline-dev libreadline6-dev libsqlite3-dev tk-dev libffi-dev libpng-dev libfreetype6-dev \
    libx11-dev libxtst-dev libfontconfig1 lzma lzma-dev  liburing-dev

# Install and configure pyenv
RUN cd ~/                                                                                               && \
    git clone https://github.com/pyenv/pyenv.git ${MYHOME}/.pyenv                                       && \
    git clone https://github.com/yyuu/pyenv-virtualenv.git ${MYHOME}/.pyenv/plugins/pyenv-virtualenv    && \
    git clone https://github.com/pyenv/pyenv-update.git ${MYHOME}/.pyenv/plugins/pyenv-update

SHELL ["/bin/bash", "-c", "-l"]

RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ${MYHOME}/.bash_profile      && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ${MYHOME}/.bash_profile   && \
    echo 'eval "$(pyenv init -)"' >> ${MYHOME}/.bash_profile                && \
    echo 'eval "$(pyenv init --path)"' >> ${MYHOME}/.bash_profile           && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> ${MYHOME}/.bash_profile

RUN cat ${MYHOME}/.bash_profile >> ${MYHOME}/.bashrc    && \
    rm -f /tmp/.bash_profile                            && \
    source ${MYHOME}/.bash_profile                      && \
    pyenv install ${PYTHONVER}                          && \
    pyenv virtualenv ${PYTHONVER} ${PYTHONNAME}         && \
    pyenv global ${PYTHONNAME}
