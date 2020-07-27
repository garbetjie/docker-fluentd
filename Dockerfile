FROM fluent/fluentd:v1.11

USER root
RUN apk add --no-cache ruby-bigdecimal && \
    fluent-gem install -V fluent-plugin-rewrite-tag-filter tzinfo fluent-plugin-bigquery
COPY fluent.conf /fluentd/etc/fluent.conf
USER fluent

VOLUME /fluentd/data

ENV PORT=20001 \
    LABEL_MAX_LENGTH=128 \
    LOCATION=EU \
    TABLE=logs \
    DATASET=logging \
    AUTH_METHOD="compute_engine" \
    PRIVATE_KEY_PATH=""
