# timelapse

A docker image to help me make some timelapses from JPG files.

## Assumptions

* They are JPG files in a flat directory structure
* I only want 1080p
* I don't care how `ffmpeg` handles images that aren't 16:9 (yet)
* 30 fps (for now)

## Usage

### Build container

```shell
$ docker build -t timelapse:latest .
```

### Running

You need an input folder and an output folder.  The image is designed to make copies of everything to reduce the change of destroying originals.  Should still make a copy first.

```shell
$ docker run --rm -it --user=$(id -u):$(id -g) -v /path/to/input_images:/input -v /path/to/output_folder:/output timelapse:latest
```

## TODO

* Center 4:3 pictures in 1080p or make the videos 4:3
* Add arguments for more flexibility (aspect ratio, etc.)
* In the summary files, use exiftool or something similar to print columns for picture info
* Add `basename` from input if possible to the output folder? (or maybe an option for a name arg)
* Metadata for output mp4 with the last date (or first date?) of image so it gets sorted in photo apps
* Auto adjust 4:3, 16:9, 16:10?

## Notes

* `jhead` documentation http://www.sentex.net/~mwandel/jhead/usage.html
* 

