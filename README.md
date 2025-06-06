# Podman Container Template

This template repository offers a one-step build process for software that can run in a Linux container. Developers can use it to create cross-platform development experiences that require minimal setup work.

![Picture of the command line shell offered by this template repository](docs/command-line.png)

## Getting Started

  1. Edit the `Dockerfile` in the `container` directory.
  2. Edit the `scripts\config.cmd` directory to set the machine name and dev directory. Choose a unique machine name to avoid collisions with other machines, or choose an existing machine name to reduce usage of system resources.
  3. Open `shell.cmd`.
  4. Type `build` to build your container image.
  5. Type `sh` to create a temporary container based on your image, and run a shell inside of it. The container will be deleted once you exit the shell.

### Your Shell Environment

 - Your project's `src` directory is mounted at the `/src` directory in your container.
 - Your current directory will be `/src` inside the shell.

### Opening Multiple Shells

The `sh` command will automatically reuse any existing running container if possible, enabling you to run multiple shells in the same container. The container ID is saved in the `container.cid` file in the root of this repository. Note that exiting the first shell will close your container, forcing the other shells to exit.

### Configuration

 - Edit `scripts\config.cmd` to change the development directory mounted in the container, as well as the machine name in Podman.
 - Edit `container\.bash_profile` to set the current directory and other Bash environment settings.
 - Edit `container\Dockerfile` to configure the development container.

## Design

### Shell Scripts for Each Platform

This project provides shell scripts for each supported platform, so that developers can just run a script to get started. Therefore, each supported platform must offer a shell script interpreter such as `bash` or `cmd`, as well as a way to download external software.

### Podman Instead of Docker

This repository uses Podman to manage containers, because Podman tends to be more reliable than Docker:

  - Podman in rootless mode doesn't use a privileged daemon that requires special access controls.
  - Podman doesn't require a centralized installation that can become corrupted over time.
  - Podman only occupies about 64 MB, plus about 8.9GB for its Linux installation on Windows Subsystem for Linux.

Here is an example of a Docker pipe permission error:

![Docker Desktop error dialog](docs/docker-error.png)

Notice that the dialog offers no way to circumvent or fix this error. Clicking **Reset to factory defaults** doesn't fix the problem, for example. [This Github issue](https://github.com/docker/for-win/issues/13663) is still open as of 2025-06-06, and is full of suggestions for fixes to try rather than concrete, reliable solutions. This issue doesn't mean that Docker is bad software, but rather that problems in complex software can be show-stoppers if all of the development environments on a given machine rely on that software. By using Podman, we can reduce this risk.

### Future Work

  - Remove hard-coded paths from some configuration files.
  - Improve error handling on shell scripts.
  - Add shell scripts for Linux.

