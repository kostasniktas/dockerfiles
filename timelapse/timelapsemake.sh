#!/bin/bash

set -e

if [ "${1}" == "--help" ]; then
  echo "Usage $(basename ${0}) [OPTIONS]"
  exit 1
fi

echo "I am $(whoami)"
echo "There are $(ls -1 /input | wc -l) input files"
echo "Testing an output touch"
touch /output/newfile

