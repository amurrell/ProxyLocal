# ProxyLocal

### **ProxyLocal** creates a reverse-proxy to allow you to use domains with any projects you have running on `localhost:<port>` 

👉 [Quick Start](#quick-start-local-project-running)
👉 [Lookup: Commands](#proxy-commands)

---

### Requirements

- Docker-compose & Docker-Engine (or Docker Desktop for mac) - using docker-compose v1 (tested w/ 1.28.5). 
  - If using v2 - then need to [disable docker-compose v2, which forces - instead of _](https://stackoverflow.com/a/69519102/2100636) in container names: `docker-compose disable-v2`
- **ProxyLocal** creates an nginx docker container that runs on port 80, so you'll need to **stop any services running on port 80** on your host machine.
- **ProxyLocal** will make edits to your `/etc/hosts` file - be aware of this. There will be no issue with any existing edits you may have.

---

## Quick Start: Local Project Running

Example: You have some project *running* at `localhost:3000`

```
git clone git@github.com:amurrell/ProxyLocal.git
cd ProxyLocal
cp sites-example.yml sites.yml
./proxy-up
./proxy-nginx -p=3000
```

⏳ The docker box will take a moment to load the first time, but after that, it'll be cached and load very fast 🏃‍♀️.

📍 Visit your site at http://local.yoursite.com. If you want to use https://local.yoursite.com then you can - but your browser will warn you because it will be using a self-signed certificate. Click advanced, continue unsafely...

👉 Have more projects on different ports? Want to change the url? Read how to [Customize your sites.yml](#customize)

👩‍💻 Whenever you want to work on your site, you'll need to `./proxy-up` and `./proxy-nginx -p=<port>`, if ProxyLocal is not already running. 
  - Once you do those steps, it can stay running - until you decide to turn off your computer or restart, or `./proxy-down`. 
  - Note that if you proxy-up *without doing the `proxy-nginx -p=<port>`* for your project it won't know that you want to work on that site (port) so it won't be "on" until you run it.

🧠 If you are using [**DockerLocal**](https://github.com/amurrell/DockerLocal) to run your projects at `localhost:<port>`, ProxyLocal will automatically be booted up for you and/or enabled when you `./site-up` in that project! It's much more convenient, especially for projects you will use often.

---

## Using with DockerLocal

If you plan to use or are already using [**DockerLocal**](https://github.com/amurrell/DockerLocal), you can install ProxyLocal so that it will automatically come up when you boot up your DockerLocal projects. The only real important thing to do is install ProxyLocal and your DockerLocals in the correct locations.

1. Simply install ProxyLocal once, at the SAME root level as all other DockerLocal Projects.

    ```
    Install Location Example:

    - ProxyLocal
    - YourSite
        - DockerLocal
        - html/index.php
        - conf
    - AnotherProject
        - DockerLocal
        - html/index.php
    ```

2. [Customize your sites.yml](#customize) to add your sites port and desired urls.

3. You will need to `./proxy-u`p and `./proxy-nginx -p=<port>` for your project after making edits to the `sites.yml`. From then on your proxy will load for you when you `./site-up`.

---

## Customize

There are couple of configuration files to give you more control.
When you modify these files you will need to `./proxy-up` again to regenerate nginx configs, update your `/etc/hosts` file, and `./proxy-nginx -p=<port>` for any projects you have running and need enabled.

### sites.yml

In `ProxyLocal/sites.yml` that you copied from `sites-example.yml` you will see a structure:

```
sites:
    80: docker.example.com
    3000: local.yoursite.com
```

You put the PORT on the left, and the URL on the right: 

`<port>: <url>`

Notice that the urls start with a subdomain - either `docker` or `local`:

> **`local`** - You MUST use a subdomain that *starts with* "local" if you are running your project on your localhost and **not** using DockerLocal. This ensures it will use the correct nginx configuration template - `nginx.local.conf`

> **`docker`** - I typically name all my boxes with this subdomain if they are using DockerLocal. You technically can name these whatever you want. These will use `nginx.site.conf` template.

---

### Customize Nginx Configuration

The `nginx.conf` configuration file (located in `ProxyLocal/nginx.conf`) is generated when you run `proxy-up` the first time. It is copied from nginx-example.conf. You can make edits to this file and they will not be tracked in version control.

### Other nginx files

The `nginx.proxy.confg`, `nginx.site.conf`, `nginx.local.conf` are all in version control at this time, so any edits there would show modified unless you fork this project and commit the changes.

Of course in that sense they are very configurable. It's good to know that in both `nginx.site.conf` and `nginx.local.conf` there are 2 variables that will get populated: PORT and SITE - and they directly relate to the sites.yml file.

---

### Proxy Commands

There are several commands in the commands folder.

| command     	| description                                                                                                                                                                                	| options                                                                                                      	|
|-------------	|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|--------------------------------------------------------------------------------------------------------------	|
| proxy-up    	| - Turns on the proxy docker container - running on localhost:80\|443<br>- Creates a network bridge for DockerLocals to connect to<br>- Also, runs `./proxy-sites` with all options.        	|                                                                                                              	|
| proxy-down  	| Turns off the proxy docker container.                                                                                                                                                      	|                                                                                                              	|
| proxy-nginx 	| Moves nginx site configuration from sites-available to sites-enabled in the proxy container.                                                                                               	| `-p=<port>` where port is based on sites.yml                                                                 	|
| proxy-ssh   	| SSH inside of your proxy container. Useful for troubleshooting `/etc/nginx` confs.                                                                                                         	|                                                                                                              	|
| proxy-sites 	| Generates site-related config for:<br><br>- local dns config in `/etc/hosts`<br>- nginx confs in `ProxyLocal/nginx-sites`<br>- ssl certs in `ProxyLocal/ssl-certs` (these are self-signed) 	| `-h` for help<br>`-s` for ssl cert generation<br>`-g` for hosts generation<br>`-n` for nginx conf generation 	|