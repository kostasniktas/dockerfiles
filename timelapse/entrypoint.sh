#!/bin/bash

set -e

# Default user values
USER=${USER:=timelapsemaker}
PASSWORD=${PASSWORD:=mysecrets}
USERID=${USERID:=1000}

# Add the user
adduser -D -h /home/${USER} -u ${USERID} ${USER}
chown -R ${USER} /home/${USER}

echo "Command I got: ${@}"
sudo -H -u ${USER} "${@}"
