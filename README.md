# DotEnv

Installation packages and environment setup for my machine

## How it works

It's written in bash script.

The `root.sh` contains the instructions to install any package as root user. Don't edit this file to add any package. The package list should be inside the `install_packages/list` file.

If the linux distribution doesn't have the package create a function inside the `<LINUX_DISTRO>_requirements.sh` file (where LINUX_DISTRO is the linux distribution name you are using).

## Test it

Just use docker, for example:

```bash
docker build -t fedora-dev:latest -f Dockerfile.fedora .
```

You can create your own dockerfile for your distro.