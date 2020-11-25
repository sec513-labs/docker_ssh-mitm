# Docker PoC for SSH man-in-the-middle attack

This repository contains Ubuntu Xenial and Bionic Docker image build files for [ssh-mitm](https://github.com/timothybrush/ssh-mitm) project, which was originally developed by [Joe Testa](https://github.com/jtesta/ssh-mitm)

The Docker images created will run ssh-mitm in debug mode, which eliminates the need for network layer 2 attacks (i.e. ARP Spoofing). These Docker containers will be used in a lab environment to demonstrate a SSH man-in-the-middle attack.

## Build instructions

### Clone repository

```
git clone https://github.com/sec513-labs/docker_ssh-mitm
```

```
cd docker_ssh-mitm
```

### Build Docker image

The build requires the target host and port (if non-standard SSH port) to be defined during the Docker image build.


This builds an Ubuntu Xenial image name `ssh-mitm:xenial` with a target of `192.168.1.2`.

```
docker build -f Dockerfile.xenial -t ssh-mitm:xenial --build-arg host=192.168.1.2 .
```

This builds an Ubuntu Bionic image name `ssh-mitm:bionic` with a target of `192.168.1.5` on port `2020`.

```
docker build -f Dockerfile.bionic -t ssh-mitm:bionic --build-arg host=192.168.1.5 --build-arg port=2020 .
```

### Running Docker container

The following commands are examples of commands that may be used to start a container based on an image.

The ssh-mitm daemon is configured to listen on port 2222, which the Docker image exposes, so the Docker run command needs to map a port to this into the container. This first run command maps port 2222 on the host to port 2222 inside the container. The --rm flag will remove the container when stopped. The -v flag is used to map a volume into the container allowing the daemon's log files to persist when the container has been removed. The --init flag allows the container to respond signals correctly including SIGTERM. Finally, this command uses the Ubuntu Xenial image built above.

```
docker run --rm -it -p 2222:2222 -v ${PWD}/log:/home/ssh-mitm/log --init ssh-mitm:xenial
```

As mentioned above, the ssh-mitm daemon is configured to listen on port 2222. This Docker run command maps localhost port 10022 to port 2222 inside the container. The other flags operate similar to the command above but this command uses the Ubuntu Bionic image built above.

```
docker run --rm -it -p 127.0.0.1:10022:2222 -v ${PWD}/log:/home/ssh-mitm/log --init ssh-mitm:bionic
```

### Testing commands

```
ssh -p <port> <user>@<ip>
```

```
sftp -P <port> <user>@<ip>
```

### Session logs

Running a Docker container with a writable volume mapping will have session files and transmitted files saved to that path.

