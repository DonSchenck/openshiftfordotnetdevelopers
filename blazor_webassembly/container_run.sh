# This script will replace the value in the files.
# By replacing the value with the contents of the environment variable,
#   we are able to specify the qotd webapi URL at runtime.
# E.g. podman run -e QOTD_API_URL="https://foo/bar/quotes/random" quay.io/donschenck/qotd-frontend:latest

sed -i "s|ERROR_THE_API_URL_HAS_NOT_BEEN_SET|$API_URL|g" ./appsettings.json
nginx -g "daemon off;"