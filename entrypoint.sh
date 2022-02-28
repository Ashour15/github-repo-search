#!/bin/bash
echo "Entrypoint"
set -e
# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

bundle exec rails assets:precompile
echo "bundle exec rails assets:precompile DONE"
bundle exec rails server -p 3000 -b 0.0.0.0

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
