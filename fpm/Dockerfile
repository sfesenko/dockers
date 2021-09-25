FROM alpine as base

RUN apk add --no-cache \
# runtime
    ruby \
    rpm \
    tar \
    libarchive-tools \
    zstd \
    binutils \
# dev
    ruby-dev \
    ruby-etc \
    gcc \
    libffi-dev \
    make \
    libc-dev

RUN gem install --no-document fpm

# remove dev
RUN apk del \
    ruby-dev \
    gcc \
    libffi-dev \
    make \
    libc-dev

FROM scratch
LABEL org.opencontainers.image.authors="Sergii Fesenko"

COPY --from=base / /
WORKDIR /w

ENTRYPOINT [ "fpm" ]
