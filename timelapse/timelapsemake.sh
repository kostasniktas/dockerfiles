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

echo "Original image listing" > "${OUTPUT}/original.list.txt"
ls -1 "${OUTPUT}/sorted_images" >> "${OUTPUT}/original.list.txt"

echo ""
echo Renaming images
shopt -s nocaseglob
jhead -ntimelapse_%Y-%m-%d_%H%M%S "${OUTPUT}"/sorted_images/*.jpg | tee "${OUTPUT}/conversion.list.txt"
shopt -u nocaseglob

echo "Sorted image listing" > "${OUTPUT}/sorted.list.txt"
ls -1 "${OUTPUT}/sorted_images" >> "${OUTPUT}/sorted.list.txt"

# shellcheck disable=SC2034
SCALE_HD="hd1080"
SCALE_43="1440x1080"

FRAME_COUNT=$(find "${OUTPUT}/sorted_images" | wc -l)
echo ""
echo "Generating timelapse from ${FRAME_COUNT} frames"
ffmpeg -f image2 -r 30 -pattern_type glob -i "${OUTPUT}"'/sorted_images/*.jpg' -s "${SCALE_43}" -vcodec libx264 "${OUTPUT}/timelapse_${CURRENT}.mp4"

echo ""
echo "Timelapse at ${OUTPUT}/timelapse_${CURRENT}.mp4"


cat >"${OUTPUT}/summary.txt" <<EOF

Original files: original.list.txt
Sorted files: sorted.list.txt
Number of images: $(find "${OUTPUT}/sorted_images" | wc -l)
Timelapse: timelapse_${CURRENT}.mp4

EOF
