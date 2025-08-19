# PostgreSQL with pgx_ulid

This repository provides a Docker image for **PostgreSQL** with the [pgx_ulid](https://github.com/pksunkara/pgx_ulid) extension preinstalled.

## Usage

Pull the image from GitHub Container Registry:

```bash
docker pull ghcr.io/kavist/postgres-ulid:17
```

Run Postgres with the extension enabled:

```bash
docker run --name pgx-ulid -e POSTGRES_PASSWORD=secret -p 5432:5432 ghcr.io/kavist/postgres-ulid:17
```

The image automatically installs the `pgx_ulid` extension at startup.

```sql
CREATE EXTENSION IF NOT EXISTS pgx_ulid;
SELECT gen_ulid();
```

## License

MIT
