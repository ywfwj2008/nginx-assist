# Nginx Compoents for My Docker Images

## Installation

    git clone https://github.com/ywfwj2008/docker-components.git

## usage
### run wish mysql
```
docker run --name mysql \
           -v /home/conf/mysql:/etc/mysql/conf.d \
           -v /home/mysql:/var/lib/mysql \
           -e MYSQL_ROOT_PASSWORD=my-secret-pw \
           -d mysql
```

```
docker run --name web \
           --link mysql:localmysql \
           -v /home/conf/vhost:/usr/local/nginx/conf/vhost \
           -v /home/conf/rewrite:/usr/local/nginx/conf/rewrite \
           -v /home/wwwlogs:/home/wwwlogs \
           -v /home/wwwroot:/home/wwwroot \
           -p 80:80 -p 443:443 \
           -d ywfwj2008/php-nginx
```
### run didn't with mysql
```
docker run --name web \
           -v /home/wwwlogs:/home/wwwlogs \
           -v /home/wwwroot:/home/wwwroot \
           -p 80:80 -p 443:443 \
           -d ywfwj2008/php-nginx
```
### nginx control
start|stop|status|restart|reload|configtest
```
docker exec -d web service nginx restart
```
### php control
start|stop|restart|reload|status
```
docker exec -d web service php-fpm restart
```