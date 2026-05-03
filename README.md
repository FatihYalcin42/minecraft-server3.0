# Minecraft Server Docker Project

A Dockerized Vanilla Minecraft Java server with persistent world storage and environment-based configuration. The project is designed to run locally or on a cloud VM and exposes the server on port `8888`.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Testing](#testing)
- [Repository Contents](#repository-contents)
- [Security Notes](#security-notes)
- [Contributing](#contributing)
- [License](#license)


## Requirements

- Docker
- Docker Compose
- A cloud VM or local machine that can run Docker
- TCP port `8888` opened in the VM firewall or security group
- Minecraft Java Edition for an in-game connection test

## Installation

1. Clone the repository:

```sh
git clone https://github.com/FatihYalcin42/minecraft-server.git
cd minecraft-server
```

2. Create a local environment file:

```sh
cp .env.example .env
```

3. Accept the Minecraft EULA in `.env`:

```env
EULA=true
```

4. Build and start the server:

```sh
docker compose up --build -d
```

5. Check that the container is running:

```sh
docker compose ps
```

The server is reachable on port `8888`:

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

Show recent logs:

```sh
docker compose logs --tail=80 mc-server
```

Restart the server:

```sh
docker compose restart mc-server
```


Connect from Minecraft Java Edition:

```text
<YOUR_VM_IP>:8888
```

The server world and runtime files are stored in `./data`. This directory is mounted into the container as `/data` and is intentionally ignored by Git.

## Configuration

Configuration is controlled through environment variables. Copy `.env.example` to `.env` and change the values there according to your needs.

These environment variables are used inside the container to dynamically generate and configure the `server.properties` file for the Minecraft server.

| Variable | Default | Description |
| --- | --- | --- |
| `EULA` | `false` | Must be set to `true` to accept the Minecraft EULA and start the server. |
| `HOST_PORT` | `8888` | Host port exposed for Minecraft clients. |
| `MEMORY_MIN` | `1G` | Initial JVM heap size. |
| `MEMORY_MAX` | `2G` | Maximum JVM heap size. |
| `ONLINE_MODE` | `true` | Enables Mojang/Microsoft account authentication. |
| `DIFFICULTY` | `easy` | Minecraft difficulty value. |
| `MOTD` | `Docker Minecraft Server` | Message shown in the Minecraft server list. |
| `LEVEL_NAME` | `world` | Name of the world directory. |
| `MAX_PLAYERS` | `20` | Maximum number of players allowed on the server. |

Example `.env`:

## Environment Setup

Use the example file as a reference:

[View `.env.example`](./.env.example)

Or copy it:

```bash
cp .env.example .env
```


For a temporary demo-client test, `ONLINE_MODE=false` can be used if the client cannot create a valid Minecraft session. For a public server, keep `ONLINE_MODE=true`.

Shell variables are referenced with the `${VARIABLE_NAME}` syntax to avoid interpretation errors. Non-sensitive defaults are configured in `docker-compose.yaml`; sensitive values should be provided through `.env` and never committed.

## Testing

Verify the Compose configuration:

```sh
docker compose config
```

Verify that the server starts:

```sh
docker compose up --build -d
docker compose ps
docker compose logs --tail=80 mc-server
```

The logs should contain a line similar to:

```text
Done (...)! For help, type "help"
```

Verify that the VM is listening on port `8888`:

```sh
ss -tulpn | grep 8888
```

Verify persistence after a restart:

```sh
docker compose restart mc-server
ls data/world
```

The world files should still exist after the restart.

## Repository Contents

- `Dockerfile`: Builds a custom Minecraft server image from a Java runtime image.
- `docker-entrypoint.sh`: Creates the runtime configuration and starts the server.
- `.env.example`: Shows the supported environment variables.
- `server.jar`: Official Minecraft Java server application.

## Security Notes

- Do not commit `.env`.
- Do not commit SSH keys.
- Do not commit passwords, tokens, usernames, or other sensitive data.
- Use environment variables for runtime configuration.
- Keep variable names in `UPPER_CASE_WITH_UNDERSCORE`.
- Keep `ONLINE_MODE=true` for real public servers.

## Contributing

This is a coursework repository and is not intended for external contributions. If you want to extend it, create a feature branch, test the Docker setup, and open a pull request with a clear description of the change.

## License

No license has been specified for this coursework repository. Contact the repository owner before reusing or redistributing the project.
