FROM ubuntu:jammy

#https://github.com/moby/moby/issues/27988
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update; apt-get install -y wget curl net-tools bmon htop netcat-traditional pciutils; apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /usr

# Install dependencies

CMD ["/bin/bash"]