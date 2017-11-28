FROM alpine:3.6


ARG PHP_PACKAGE
ARG BUILD_DATE
ARG VCS_REF


LABEL \
 org.label-schema.name="Base docker image for PHP applications" \
 org.label-schema.description="Alpine based docker image with Apache (prefork) & PHP module." \
 org.label-schema.vcs-url="https://github.com/prog/docker-php" \
 org.label-schema.vcs-ref="${VCS_REF}" \
 org.label-schema.build-date="${BUILD_DATE}" \
 org.label-schema.schema-version="1.0"


RUN : \
 && apk --update add "${PHP_PACKAGE}" \
 && mkdir -p /run/apache2 \
 && ln -sfT /dev/stderr /var/log/apache2/error.log \
 && ln -sfT /dev/stdout /var/log/apache2/access.log \
 && :


COPY root /


ENTRYPOINT ["image--entrypoint"]
CMD ["image--command"]


EXPOSE 80
