# ProxyLocal

**ProxyLocal** creates a reverse-proxy to allow you to use domains with any projects you have running on localhost:PORT

**ProxyLocal** creates an nginx docker container that runs on port 80, so you'll need to stop any services running on port 80 on your host machine.

---

## Requirements

- Docker-compose (tested with docker-compose version 1.24.1, build 4667896b)
  - If using v2 - then need to [disable docker-compose v2, which forces - instead of _](https://stackoverflow.com/a/69519102/2100636) in container names: `docker-compose disable-v2`
- Docker-Engine

Tested with:

```
Client: Docker Engine - Community
 Version:           19.03.1
 API version:       1.40
 Go version:        go1.12.5
 Git commit:        74b1e89
 Built:             Thu Jul 25 21:21:05 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.1
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.5
  Git commit:       74b1e89
  Built:            Thu Jul 25 21:19:41 2019
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.2.6
  GitCommit:        894b81a4b802e4eb2a91d1ce216b8817763c29fb
 runc:
  Version:          1.0.0-rc8
  GitCommit:        425e105d5a03fabd737a126ad93d62a9eeede87f
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683

```

## Get Started

- `git clone git@github.com:amurrell/ProxyLocal.git`
- `cd ProxyLocal/commands`
- `./proxy-up`

Great job! The reverse-proxy is running. Go to [localhost](http://localhost) for site setup instructions.

---

## Customize

If you need to alter the nginx.conf, you can edit the generated file after running `./proxy-up` and just re-run it.

---

## DockerLocal, ProxyLocal's sibling

Run your site on a port on localhost with [DockerLocal](https://github.com/amurrell/DockerLocal).

Add the site to ProxyLocal sites.yml. Run your localhost:port sites on a domain.
