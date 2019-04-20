FROM alpine:3.9
ENV PYTHONUNBUFFERED 1

RUN echo 'http://mirrors.aliyun.com/alpine/v3.9/main/' > /etc/apk/repositories
RUN echo 'http://mirrors.aliyun.com/alpine/v3.9/community/' >> /etc/apk/repositories

RUN apk add --no-cache ca-certificates
RUN apk add --no-cache --virtual .build-deps  \
		bzip2-dev \
		coreutils \
		dpkg-dev dpkg \
		expat-dev \
		findutils \
		gcc \
		gdbm-dev \
		libc-dev \
		libffi-dev \
		libnsl-dev \
		libtirpc-dev \
		linux-headers \
		make \
		ncurses-dev \
		openssl-dev \
		pax-utils \
		readline-dev \
		sqlite-dev \
		tcl-dev \
		tk \
		tk-dev \
		util-linux-dev \
		xz-dev \
		postgresql-dev \
		nghttp2-libs \
		zlib-dev \ 
		nghttp2-libs \ 
		libssh2 \
		libcurl \
		python-dev 

RUN apk add --no-cache jpeg-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev libpq openssl-dev ncurses-dev py-pip py-curl

RUN pip install --no-cache -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com thumbor tc_aws

RUN apk del .build-deps
