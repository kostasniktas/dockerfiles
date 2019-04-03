#!/bin/bash

set -e

if [ "${1}" == "--help" ]; then
  SCRIPT_NAME=$(basename "${0}")
  echo "Usage ${SCRIPT_NAME} [OPTIONS]"
  exit 1
fi

CURRENT=$(date +%s)
OUTPUT="/output/${CURRENT}"

echo ""
echo Making a copy of the input images
mkdir -p "${OUTPUT}/sorted_images"
cp /input/* "${OUTPUT}/sorted_images"

echo ""
echo Renaming images
shopt -s nocaseglob
jhead -ntimelapse_%Y-%m-%d_%H%M%S "${OUTPUT}"/sorted_images/*.jpg
shopt -u nocaseglob

echo ""
echo "Generating timelapse"
ffmpeg -f image2 -r 30 -pattern_type glob -i "${OUTPUT}"/sorted_images/*.jpg -s hd1080 -vcodec libx264 "${OUTPUT}/timelapse_${CURRENT}.mp4"

echo ""
echo "Timelapse at ${OUTPUT}/timelapse_${CURRENT}.mp4"

