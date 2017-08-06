# ProxyLocal

**ProxyLocal** creates a reverse-proxy to allow you to use domains with any projects you have running on localhost:PORT

**ProxyLocal** creates an nginx docker container that runs on port 80, so you'll need to stop any services running on port 80 on your host machine.

---

## Requirements

- Docker (Tested with Docker version 17.03.1-ce, build c6d412e)
- Docker-Compose (Tested with docker-compose version 1.12.0, build b31ff33)

## Get Started

- `git clone git@github.com:amurrell/ProxyLocal.git`
- `cd ProxyLocal/commands`
- `./proxy-up`

Great job! The reverse-proxy is running. Go to [localhost](http://localhost) for site setup instructions.

---

## DockerLocal, ProxyLocal's sibling

Run your site on a port on localhost with [DockerLocal](https://github.com/amurrell/DockerLocal). 

Add the site to ProxyLocal sites.yml. Run your localhost:port sites on a domain.