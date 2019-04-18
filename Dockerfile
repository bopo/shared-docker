FROM alpine:3.9
ENV PYTHONUNBUFFERED 1

COPY ./compose/django/standard/supervisor /etc/supervisor
COPY ./compose/django/standard/supervisor.sh /supervisor.sh
COPY ./compose/django/standard/entrypoint.sh /entrypoint.sh
COPY ./project/app/requirements /requirements.txt

RUN echo 'http://mirrors.aliyun.com/alpine/v3.9/main/' > /etc/apk/repositories
RUN echo 'http://mirrors.aliyun.com/alpine/v3.9/community/' >> /etc/apk/repositories

RUN apk add --update supervisor py3-lxml libevent py3-pillow py3-psycopg2 python3-dev python3 py3-gevent gcc g++ postgresql-dev zlib-dev jpeg-dev
RUN pip3 install -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com -r /app/requirements/dev.txt
RUN rm -rf /app/requirements

RUN sed -i 's/\r//' /entrypoint.sh
RUN sed -i 's/\r//' /supervisor.sh

RUN chmod +x /entrypoint.sh
RUN chmod +x /supervisor.sh

RUN mkdir /app

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]
