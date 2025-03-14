# docker-taskchampion-sync-server

This is an alternative basic docker setup for the [taskchampion-sync-server](https://github.com/GothenburgBitFactory/taskchampion-sync-server)

Based of the [linuxserver.io base image](https://github.com/linuxserver/docker-baseimage-alpine) (actually using the beets image as a template, as docs on how to setup the base image correctly are a little thin), as it has some pretty awesome boilerplate setup for running binaries in docker out of the box.

## Why Use this?

- I tried running the [included docker-compose](https://github.com/GothenburgBitFactory/taskchampion-sync-server/blob/main/docker-compose.yml) setup in the taskchampion-sync-server repo, but kept hitting stumbling blocks with permissions. As I already run a lot of lsio containers, I figured that I can work with those permission setups better, so went with that instead.
- I highly recommend trying setup via the [official instructions](https://github.com/GothenburgBitFactory/taskchampion-sync-server?tab=readme-ov-file#running-the-server) first, and see if that works for you.

## Usage

### Docker Compose

Includes an [example compose](./docker-compose.yml) file to get you started:

```yaml
services:
  taskchampion:
    build: .
    restart: unless-stopped
    volumes:
      - "./data:/data"
    ports:
      - 8080:8080
    environment:
      - RUST_LOG=debug
      - UID=1000
      - GID=1000
      - TZ=Etc/UTC
      - DATA_DIR=/data
      - LISTEN=0.0.0.0:8080
```

## env Vars

Supports all `ENV_VARS` specified in the main repo.
Also supports the following utility vars:

| Var   | Description                       | Example   |
| ----- | --------------------------------- | --------- |
| `TZ`  | Sets timezone info                | `Etc/UTC` |
| `UID` | Sets user ID to run container as  | `1000`    |
| `GID` | Sets group ID to run container as | `1000`    |

## References

1. [https://docs.linuxserver.io/general/container-branding/]
