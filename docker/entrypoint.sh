#!bin/bash
set -e
rm -f /my_app/tmp/pids/server.pid
exec "$@"

