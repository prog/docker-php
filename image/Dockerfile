FROM alpine:3.6


RUN : \
 && apk --update add "php7-apache2<7.1.999" \
 && mkdir -p /run/apache2 \
 && ln -sfT /dev/stderr /var/log/apache2/error.log \
 && ln -sfT /dev/stdout /var/log/apache2/access.log \
 && :


COPY apache.httpd.conf /etc/apache2/httpd.conf
COPY bin/* /usr/bin/


ENTRYPOINT ["webserver--entrypoint"]
CMD ["httpd", "-D", "FOREGROUND"]


EXPOSE 80
