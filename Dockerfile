ARG postgresql_major=17
ARG postgresql_release=${postgresql_major}.6

ARG pgx_ulid_release=0.2.0

####################
# Postgres
####################
FROM postgres:${postgresql_release} AS base

# Redeclare args for use in subsequent stages
ARG TARGETARCH
ARG postgresql_major

####################
# Extension: pgx_ulid
####################
FROM base AS pgx_ulid

# Download package archive
ARG pgx_ulid_release
ADD "https://github.com/pksunkara/pgx_ulid/releases/download/v${pgx_ulid_release}/pgx_ulid-v${pgx_ulid_release}-pg${postgresql_major}-${TARGETARCH}-linux-gnu.deb" \
  /tmp/pgx_ulid.deb

####################
# Collect extension packages
####################
FROM scratch AS extensions
COPY --from=pgx_ulid /tmp/*.deb /tmp/

####################
# Build final image
####################
FROM base AS production

# Setup extensions
COPY --from=extensions /tmp /tmp

RUN apt-get update && apt-get install -y --no-install-recommends \
  /tmp/*.deb \
  && rm -rf /var/lib/apt/lists/* /tmp/*

ENV PGDATA=/var/lib/postgresql/${postgresql_major}/docker

RUN mkdir -p /docker-entrypoint-initdb.d
COPY init-ulid.sql /docker-entrypoint-initdb.d/10-ulid.sql
