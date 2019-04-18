FROM python:alpine
ENV PYTHONUNBUFFERED 1

COPY ./standard/supervisor /etc/supervisor
COPY ./standard/supervisor.sh /supervisor.sh
COPY ./standard/entrypoint.sh /entrypoint.sh
COPY ./standard/server/requirements /app/requirements

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
		zlib-dev

RUN apk add --no-cache jpeg-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev libpq openssl-dev ncurses-dev
RUN pip install --no-cache -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com pillow psycopg2-binary gunicorn meinheld

RUN pip install -r /app/requirements/pre.txt 
RUN rm -rf /app/requirements 
RUN apk del .build-deps

RUN sed -i 's/\r//' /entrypoint.sh
RUN sed -i 's/\r//' /supervisor.sh

RUN chmod +x /entrypoint.sh
RUN chmod +x /supervisor.sh

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]
