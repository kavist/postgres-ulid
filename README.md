# PostgreSQL with pgx_ulid

This repository provides a Docker image for **PostgreSQL** with the [pgx_ulid](https://github.com/pksunkara/pgx_ulid) extension preinstalled.

This image uses `/var/lib/postgresql/17/docker` as its `PGDATA` folder by default, to [follow the change made to upstream `postgres` Docker image](https://github.com/docker-library/postgres/pull/1259). Make sure the volume mapping matces the path.

## Usage

Pull the image from GitHub Container Registry:
```bash
docker pull ghcr.io/kavist/postgres-ulid:17
```

Run Postgres with the extension enabled:
```bash
docker run \
  --name postgres-ulid \
  -e POSTGRES_PASSWORD=supersecret \
  -p 5432:5432 \
  -v pgdata:/var/lib/postgresql/17/docker \
  ghcr.io/kavist/postgres-ulid:17
```

The image automatically installs the `pgx_ulid` extension at startup.
```sql
CREATE EXTENSION IF NOT EXISTS pgx_ulid;
SELECT gen_ulid();
```

Example using Docker Compose:
```yaml
services:
  postgres:
    image: ghcr.io/kavist/postgres-ulid:17
    container_name: postgres-ulid
    environment:
      POSTGRES_PASSWORD: supersecret
    ports:
      - "5432:5432"
    volumes:
      - ./pgdata:/var/lib/postgresql/17/docker
```

## License

MIT
