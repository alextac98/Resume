FROM ubuntu
ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt upgrade -y

RUN apt install -y --no-install-recommends \
    nano \
    vim \
    git \
    ssh-client

# Install Latex Tools
RUN apt install -y --no-install-recommends texlive-full

# Remove apt lists to save space
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /latex-ws

WORKDIR /latex-ws