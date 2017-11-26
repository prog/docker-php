FROM alpine:3.6


ARG PHP_PACKAGE


RUN : \
 && apk --update add "${PHP_PACKAGE}" \
 && mkdir -p /run/apache2 \
 && ln -sfT /dev/stderr /var/log/apache2/error.log \
 && ln -sfT /dev/stdout /var/log/apache2/access.log \
 && :


COPY apache.httpd.conf /etc/apache2/httpd.conf
COPY bin/* /usr/bin/


ENTRYPOINT ["webserver--entrypoint"]
CMD ["httpd", "-D", "FOREGROUND"]


EXPOSE 80
