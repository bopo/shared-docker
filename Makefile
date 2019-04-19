# Makefile six
CWD=`pwd`

.PHONY: docs clean start build setup

help:
	@echo "setup    - 安装基本依赖(初始化)"
	@echo "fetch    - 更新版本库最新代码"
	@echo "clean    - 清理编译垃圾数据"
	@echo "build    - 编译所需镜像"
	@echo "start    - 开始项目容器"
	@echo "stop     - 停止项目容器"
	@echo "destry   - 销毁项目容器"
	@echo "doctor   - 所有容器自检"
	@echo "restart  - 重启项目容器"

doctor:
	docker-compose run --rm shared doctor

destry:
	docker-compose rm -a -f

clean: clean-pyc
	rm -rf build
	rm -rf ./compose/django/server
	rm -rf ./compose/django/standard/server

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

volume:
	rm -rf ./volumes

	mkdir -p ./volumes/postgres/data
	mkdir -p ./volumes/postgres/conf

	mkdir -p ./volumes/elastic/data
	mkdir -p ./volumes/elastic/conf

	mkdir -p ./volumes/django/data
	mkdir -p ./volumes/django/conf

	mkdir -p ./volumes/redis/data
	mkdir -p ./volumes/redis/conf

	mkdir -p ./volumes/nginx/data
	mkdir -p ./volumes/nginx/conf	

fetch: volume
	rm -rf ./compose/django/standard/server && cp -r ../server ./compose/django/standard/
	cp -r ../server/* ./volumes/django/data

	cp ./compose/nginx/nginx.conf volumes/nginx/conf
	cp -R ./compose/django/standard/supervisor volumes/django/conf

	cp volumes/django/data/env.docker volumes/postgres/.env
	cp volumes/django/data/env.docker volumes/elastic/.env
	cp volumes/django/data/env.docker volumes/django/.env
	cp volumes/django/data/env.docker volumes/nginx/.env
	cp volumes/django/data/env.docker volumes/redis/.env

build: fetch
	docker build ./compose/postgres -t postgres:shared
	docker build ./compose/django -t django:shared
# 	docker build ./compose/python -t python:shared
	docker build ./compose/nginx -t nginx:shared

stop: 
	docker-compose stop

start: 
	docker-compose start

setup: build
	docker-compose up -d

restart: 
	docker-compose restart

# DO NOT DELETE
