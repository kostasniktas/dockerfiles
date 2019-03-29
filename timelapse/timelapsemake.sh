#!/bin/bash

set -e

if [ "${1}" == "--help" ]; then
  SCRIPT_NAME=$(basename "${0}")
  echo "Usage ${SCRIPT_NAME} [OPTIONS]"
  exit 1
fi

CURRENT=$(date +%s)

echo ""
echo Making a copy of the input images
mkdir /output/sorted_images
cp /input/* /output/sorted_images

echo ""
echo Renaming images
shopt -s nocaseglob
jhead -ntimelapse_%Y-%m-%d_%H%M%S /output/sorted_images/*.jpg
shopt -u nocaseglob

echo ""
echo "Generating timelapse"
ffmpeg -f image2 -r 30 -pattern_type glob -i '/output/sorted_images/*.jpg' -s hd1080 -vcodec libx264 "/output/timelapse_${CURRENT}.mp4"

echo ""
echo "Timelapse at timelapse_${CURRENT}.mp4"

