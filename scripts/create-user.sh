#!/bin/bash

user=${1}

devpi use http://devpi-server:3141/

# Create devpi user (propmt for password)
devpi user -c ${user:-tester}
