# syntax=docker/dockerfile:1
# set version label
ARG RUST_VERSION=1.85

# Builder image
FROM docker.io/rust:${RUST_VERSION}-alpine AS builder
RUN apk add -U --no-cache libc-dev unzip

ARG TASKCHAMPION_VERSION=v0.6.0

RUN mkdir /src
WORKDIR /src

RUN wget "https://github.com/GothenburgBitFactory/taskchampion-sync-server/archive/refs/tags/$TASKCHAMPION_VERSION.zip"
RUN unzip "$TASKCHAMPION_VERSION.zip"
RUN mv ./taskchampion-sync-server*/* ./ && \
  rm "$TASKCHAMPION_VERSION.zip"


RUN cargo build --release

# Run image
FROM ghcr.io/linuxserver/baseimage-alpine:3.21

ARG VERSION=v0.1.0
ARG BUILD_DATE
ARG GITHUB_SHA

LABEL build_version="taskchampion-sync-server:- ${VERSION} Build-date: ${BUILD_DATE} SHA: ${GITHUB_SHA}"
LABEL maintainer="Pete-Hamlin"

COPY --from=builder /src/target/release/taskchampion-sync-server /bin

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8080
VOLUME /config
VOLUME /data
