#!/usr/bin/env bash
#Filename    : docker_nginx_install.sh
#Author      : Gu Haohao
#Version     : 1.0
#Time        : 2022/04/03 14:18:29
#Description : docker nginx install

nginx_doc='/opt/docker/nginx'
nginx_conf_doc='/opt/docker/nginx/conf'

nginx_install() {
    docker run -p 80:80 --name nginx -d --privileged=true nginx
    [ ! -d "$nginx_doc" ] && mkdir "$nginx_doc"
    [ ! -d "$nginx_conf_doc" ] && mkdir "$nginx_conf_doc"
    docker cp nginx:/etc/nginx/nginx.conf $nginx_conf_doc/nginx.conf
    docker cp nginx:/etc/nginx/conf.d $nginx_conf_doc/conf.d
    docker cp nginx:/usr/share/nginx/html $nginx_doc
    docker rm -f nginx
    docker run -p 80:80 --name nginx --restart=always -v $nginx_conf_doc/nginx.conf:/etc/nginx/nginx.conf -v $nginx_conf_doc/conf.d:/etc/nginx/conf.d -v $nginx_doc/html:/usr/share/nginx/html -v $nginx_doc/logs:/var/log/nginx -d --privileged=true nginx
    echo "nginx start SUCCESS!"
    curl http://localhost
}

nginx_install
