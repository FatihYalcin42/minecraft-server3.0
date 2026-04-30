# Minecraft Server Docker Project

## Table of Contents

- [Description](#description)
- [Repository Contents](#repository-contents)
- [Quickstart](#quickstart)
- [Usage](#usage)
- [Configuration](#configuration)
- [Testing](#testing)
- [Security Notes](#security-notes)

## Description

This repository contains a Docker-based Vanilla Minecraft Java server. The image is built from a Java runtime base image and uses the local `server.jar` file from this repository. The server data is stored outside the container so that worlds and configuration survive container restarts.

## Repository Contents

- `Dockerfile`: Builds a custom Minecraft server image from a Java runtime image.
- `docker-entrypoint.sh`: Creates the runtime configuration and starts the server.
- `docker-compose.yaml`: Defines the `mc-server` service, port mapping, environment configuration, restart policy, and persistent volume.
- `.env.example`: Shows the supported environment variables.
- `.gitignore`: Excludes local runtime data, logs, and secret environment files.
- `server.jar`: Official Minecraft Java server application.
- `README.md`: Documents how to build, configure, run, and test the project.
- `Minecraft Server Checkliste.pdf`: Original project checklist.

## Quickstart

Requirements:

- Docker
- Docker Compose
- A Java Minecraft client for optional in-game testing

Create your local environment file:

```sh
cp .env.example .env
```

Accept the Minecraft EULA by changing this value in `.env`:

```sh
EULA=true
```

Build and start the server:

```sh
docker compose up --build -d
```

The Minecraft server is reachable on port `8888` by default:

```text
<YOUR_VM_IP>:8888
```

## Usage

Start the server:

```sh
docker compose up -d
```

Stop the server:

```sh
docker compose down
```

Show logs:

```sh
docker compose logs -f mc-server
```

Rebuild the image:

```sh
docker compose build --no-cache
```

The server world and runtime files are stored in `./data`. This directory is mounted into the container as `/data` and is intentionally ignored by Git.

## Configuration

Configuration is controlled through environment variables. Copy `.env.example` to `.env` and change the values there.

| Variable | Default | Description |
| --- | --- | --- |
| `EULA` | `false` | Must be set to `true` to accept the Minecraft EULA and start the server. |
| `HOST_PORT` | `8888` | Host port exposed to the internet. |
| `MEMORY_MIN` | `1G` | Initial JVM heap size. |
| `MEMORY_MAX` | `2G` | Maximum JVM heap size. |
| `ONLINE_MODE` | `true` | Enables Mojang account authentication. |
| `DIFFICULTY` | `easy` | Minecraft difficulty value. |
| `MOTD` | `Docker Minecraft Server` | Message shown in the Minecraft server list. |
| `LEVEL_NAME` | `world` | Name of the world directory. |

Shell variables are referenced with the `${VARIABLE_NAME}` syntax to avoid interpretation errors. Non-sensitive defaults are configured in `docker-compose.yaml`; sensitive values should be provided through `.env` and never committed.

## Testing

Before submitting the project, verify the following:

1. Build succeeds:

```sh
docker compose build
```

2. The server starts:

```sh
docker compose up -d
docker compose logs -f mc-server
```

3. The server listens on port `8888`:

```sh
docker compose ps
```

4. A Java Minecraft client can connect to:

```text
<YOUR_VM_IP>:8888
```

5. Data persists after a restart:

```sh
docker compose restart mc-server
```

After the restart, the `./data` directory should still contain the world and server configuration files.

## Security Notes

- Do not commit `.env`.
- Do not commit SSH keys.
- Do not commit passwords, tokens, usernames, IP addresses, or other sensitive data.
- Use environment variables for runtime configuration.
- Keep variable names in `UPPER_CASE_WITH_UNDERSCORE`.
