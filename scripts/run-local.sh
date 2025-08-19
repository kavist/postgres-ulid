#!/usr/bin/env bash
docker buildx build --platform linux/amd64,linux/arm64 -t kavist/postgres-ulid .
docker run --rm -e POSTGRES_PASSWORD=secret -p 5432:5432 kavist/postgres-ulid
