FROM alpine

RUN apk add --no-cache \
      --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
      bash \
      ffmpeg \
      jhead

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY timelapsemake.sh /usr/local/bin/timelapsemake.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD ["/usr/local/bin/timelapsemake.sh", "--help"]

