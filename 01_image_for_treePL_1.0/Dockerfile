FROM ubuntu:22.04

ENV TERM=linux
ENV DEBIAN_FRONTEND=noninteractive
ENV LD_LIBRARY_PATH=/usr/lib64

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    libnlopt-dev \
    libnlopt0 \
    libcolpack-dev \
    make \
    libomp-dev \
    build-essential \
    autoconf \
    autotools-dev \
    automake \
    libtool \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./adol-c /usr/local/src/adol-c

RUN ls -l /usr/local/src/adol-c/

RUN cd /usr/local/src/adol-c/ADOL-C-releases-2.7.2/ && \
    ./update_versions.sh && \
    ./configure --with-openmp-flag=-fopenmp --prefix=/usr && \
    make && \
    make install


COPY ./treepl /usr/local/src/treepl

RUN cd /usr/local/src/treepl/treePL-1.0/ && \
    ./configure && \
    make && \
    mkdir /input

# the command that will be executed when a container is started from the image
# ENTRYPOINT ["/usr/local/src/treepl/treePL-1.0/treePL"]
