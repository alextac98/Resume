FROM ubuntu

RUN apt update && apt upgrade -y

RUN apt install -y --no-install-recommends \
    nano \
    vim \
    git \
    ssh-client

# Create a basic user
ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

RUN apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Install Latex Tools
RUN DEBIAN_FRONTEND="noninteractive" apt install -y --no-install-recommends texlive-full

# Remove apt lists to save space
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/$USERNAME/latex-ws

WORKDIR /home/$USERNAME/latex-ws