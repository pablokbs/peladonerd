# syntax=docker/dockerfile:experimental

FROM alpine

RUN apk add --update --no-cache git openssh-client

RUN mkdir -p -m 0600 ~/.ssh && \
  ssh-keyscan github.com >> ~/.ssh/known_hosts

RUN --mount=type=secret,id=ssh,target=/root/.ssh/id_rsa git clone git@github.com:pablokbs/privado.git