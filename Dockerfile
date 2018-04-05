FROM nvidia/cuda:9.1-devel
LABEL maintainer "Disa Mhembere <disa@cs.jhu.edu>"

RUN apt-get update
RUN apt-get -o Dpkg::Options::="--force-confold" --force-yes -y upgrade

RUN apt-get -y install git \
        python-all-dev python-pip \
        vim \
        libatlas-base-dev \
        libgsl-dbg \
        libgsl-dev libgsl2 \
        wget \
        libopenblas-dev libopenblas-base

# Dependencies
RUN pip install --upgrade pip

# Create a user to run as
RUN pip install pyCUDA \
    scikit-cuda \
    numpy \
    scipy \
    pandas \
    cffi \
    Cython \
    h5py \
    jupyter

RUN useradd -ms /bin/bash ubuntu && echo "ubuntu:ubuntu" \
    | chpasswd && adduser ubuntu sudo
WORKDIR /home/ubuntu

# TODO: make with multiple procs
RUN git clone https://github.com/bioinf-jku/binet.git
WORKDIR binet
RUN pip install .

USER ubuntu
# Make a data directory for use with examples
RUN mkdir /home/ubuntu/data

# Enter bash shell
ENTRYPOINT ["bash"]
