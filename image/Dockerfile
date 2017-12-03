FROM alpine:3.6


ARG IMAGE_NAME
ARG IMAGE_DESCRIPTION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE
ARG PHP_PACKAGE


LABEL \
 org.label-schema.name="${IMAGE_NAME}" \
 org.label-schema.description="${IMAGE_DESCRIPTION}" \
 org.label-schema.vcs-url="${VCS_URL}" \
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
