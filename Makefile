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

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

fetch:
	rm -rf ./compose/django/server && cp -r ../server ./compose/django/
	test -d volumes/django || mkdir -p volumes && cp -r ../server volumes/django
	test -d volumes/nginx || mkdir -p volumes/nginx/etc && cp volumes/django/env.docker volumes/nginx/.env
	test -d volumes/redis || mkdir -p volumes/redis/etc && cp volumes/django/env.docker volumes/redis/.env
	test -d volumes/postgres || mkdir -p volumes/postgres/etc && cp volumes/django/env.docker volumes/pgsql/.env

build:
# 	docker build ./compose/postgres -t postgres:shared
	docker build ./compose/django -t django:shared
# 	docker build ./compose/python -t python:shared
# 	docker build ./compose/nginx -t nginx:shared

stop: 
	docker-compose stop

start: 
	docker-compose start

setup: build
	docker-compose up -d

restart: 
	docker-compose restart

# DO NOT DELETE
