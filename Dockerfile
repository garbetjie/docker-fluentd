FROM fluent/fluentd:v1.11

USER root
RUN apk add --no-cache ruby-bigdecimal && \
    fluent-gem install -V fluent-plugin-rewrite-tag-filter tzinfo fluent-plugin-bigquery
COPY fluent.conf /fluentd/etc/fluent.conf
USER fluent

VOLUME /fluentd/data

ENV AUTH_METHOD="compute_engine" \
    DATASET=logging \
    LABEL_MAX_LENGTH=128 \
    LOCATION=EU \
    LOG_LEVEL=info \
    PORT=20001 \
    PRIVATE_KEY_PATH="" \
    TABLE=logs
