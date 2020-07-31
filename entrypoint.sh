#!/usr/bin/env sh

# Own the data directory.
chown fluent:nogroup /fluentd/data

exec su -s /sbin/tini fluent -- /bin/entrypoint.sh "$@"
