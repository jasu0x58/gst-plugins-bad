FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

LABEL maintainer="Jan Sutter <jasu0x58@gmail.com>"

ENV NVIDIA_DRIVER_CAPABILITIES all

RUN apt-get update && apt-get install -y --no-install-recommends \
	gstreamer-1.0 \
	gstreamer1.0-tools \
	gstreamer1.0-plugins-base \
	gstreamer1.0-plugins-good \
	libgstreamer-plugins-base1.0-dev \
	wget \
	unzip \
	git \ 
	make \
	autoconf \
	autopoint \
	libtool \
	pkg-config \
	automake \
	python \
	gettext \ 
	libglib2.0-dev 

RUN wget http://developer.download.nvidia.com/compute/nvenc/v5.0/nvenc_5.0.1_sdk.zip -O nvenc_sdk.zip
RUN unzip nvenc_sdk.zip
RUN cp nvenc_5.0.1_sdk/Samples/common/inc/* /usr/local/include

ADD . /gst-plugins-bad
WORKDIR /gst-plugins-bad
RUN sh autogen.sh --disable-gtk-doc --with-cuda-prefix=/usr/local/cuda
RUN make && make install

ENV GST_PLUGIN_PATH /usr/local/lib/gstreamer-1.0/
