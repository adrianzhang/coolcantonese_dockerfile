FROM ubuntu:14.04
MAINTAINER Zhike Chan "zk.chan007@gmail.com"
ENV REFRESHED_AT 2015-2-20

## use mirror source
RUN sed 's/archive\.ubuntu\.com/mirrors\.zju\.edu\.cn/' -i /etc/apt/sources.list

RUN apt-get -qq update

## Install ekho.
RUN \
  apt-get -qqy install software-properties-common && \
  add-apt-repository ppa:hgneng/ekho && \
  apt-get -qq update && \
  apt-get -qqy install ekho

## Install ffmpeg.
# RUN \
#   sed -i '/^#.*multiverse$/s/^#\s*//' /etc/apt/sources.list && \
#   apt-get update && \
#   apt-get -qqy install libav-tools libavcodec-extra-53
RUN \
  add-apt-repository ppa:jon-severinsson/ffmpeg && \
  apt-get -qq update && \
  apt-get -qqy install ffmpeg

## Install Python.
RUN \
  apt-get -qq update && \
  apt-get install -y python python-dev python-pip python-virtualenv && \
  rm -rf /var/lib/apt/lists/*

## Install Python packages.
COPY requirements.txt /tmp/requirements.txt
WORKDIR /tmp
RUN pip install -r requirements.txt && rm -rf requirements.txt

VOLUME ["/Cantonese","/Cantonese_audio"]
WORKDIR /Cantonese

#ENTRYPOINT ["wechat.py"]
#CMD ["-h"]