#!/bin/bash
set -e 

if [ "${1}" == "devpi-server" ]; then
    shift # consume the 1st argument
    server_args="--host=0.0.0.0 --port=${PORT:-3141}"
    if test -n "${PUBLIC_URL}"; then
        server_args="${server_args} --outside-url=${PUBLIC_URL}"
    fi
    exec devpi-server ${server_args} ${@}
else
    # An unknown command: Forward as is
    exec ${@}
fi
