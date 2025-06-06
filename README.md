# Podman Container Template

This template repository automatically downloads and launches Podman on Windows 10 64-bit systems, enabling developers on Windows to easily develop software in containerized environments.

## Getting Started

  1. Edit the `Dockerfile` in the `container` directory.
  2. Edit the `scripts\config.cmd` directory to set the machine name and dev directory. Choose a unique machine name to avoid collisions with other machines, or choose an existing machine name to reduce usage of system resources.
  3. Open `shell.cmd`.
  4. Type `build` to build your container.
  5. Type `sh` to open a shell inside your container.

## Why Not Docker?

Podman tends to be more reliable than Docker Desktop because it doesn't rely on a privileged daemon or a centralized installation that can become corrupted over time. Here is an example of a Docker permission error:

![Docker Desktop error dialog](docs/docker-error.png)

