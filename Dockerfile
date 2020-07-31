FROM fluent/fluentd:v1.11

# Because the data directory needs to be chowned at startup, we'll run as root so that we can set the permissions on
# the data directory.
USER root

RUN apk add --no-cache ruby-bigdecimal && \
    fluent-gem install -V fluent-plugin-rewrite-tag-filter tzinfo fluent-plugin-bigquery
COPY fluent.conf /fluentd/etc/fluent.conf
COPY entrypoint.sh /docker-entrypoint.sh

VOLUME /fluentd/data
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["fluentd"]

ENV AUTH_METHOD="compute_engine" \
    DATASET=logging \
    LABEL_MAX_LENGTH=128 \
    LOCATION=EU \
    LOG_LEVEL=info \
    PORT=20001 \
    PRIVATE_KEY_PATH="" \
    PROJECT="" \
    TABLE=logs
