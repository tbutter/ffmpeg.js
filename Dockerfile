FROM ubuntu
SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get -y install wget python git automake libtool build-essential cmake libglib2.0-dev closure-compiler
WORKDIR root
RUN wget https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz
RUN tar xzvf emsdk-portable.tar.gz
WORKDIR /root/emsdk-portable
RUN ./emsdk update
RUN ./emsdk install sdk-1.37.40-64bit \
	    emscripten-1.37.40 \
	    node-8.9.1-64bit \
	    clang-e1.37.40-64bit
RUN ./emsdk activate sdk-1.37.40-64bit \
	    emscripten-1.37.40 \
	    node-8.9.1-64bit \
	    clang-e1.37.40-64bit

WORKDIR /root
#RUN git clone https://github.com/Kagami/ffmpeg.js.git
COPY . /root/ffmpeg.js
WORKDIR /root/ffmpeg.js

RUN cd /root/emsdk-portable/ && . ./emsdk_env.sh && cd /root/ffmpeg.js && make all