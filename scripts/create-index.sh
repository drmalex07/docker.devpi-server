#!/bin/bash

user=$(echo ${1}| cut -d'/' -f1)
user=${user:-tester}
index_name=$(echo ${1}| cut -d'/' -f2)
index_name=${index_name:-devel}

devpi use http://devpi-server:3141/

devpi login ${user}
devpi index -c ${index_name} bases=root/pypi

