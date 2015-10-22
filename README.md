Docker - Symfony VM
===
**Build a local Virtual Machine (Docker aware) which allows you to run a Symfony full stack application in Ubuntu container on any OS (including Windows/Mac)**


## Requirements

 - [msysgit](https://msysgit.github.io/) **for Windows user only** (see ["Get a nice terminal"](#get-a-nice-terminal-and-be-able-to-use-git-and-many-useful-unix-commands-on-windows) section below if you don't know how to do)
 - [VirtualBox](https://www.virtualbox.org/wiki/Downloads) 
 - [Docker Machine](https://docs.docker.com/machine/#installation) ([version 0.3.0+](https://github.com/docker/machine/releases)) => just an executable to rename `docker-machine` and to move somewhere in your `PATH`


## What's inside?

### docker-machine-dev(.bat/.sh)
A simple yet powerful script which uses Docker Machine to build a local Docker aware VM without even installing Docker. 
It's also used to set some useful aliases in the VM (such as`docker-compose` which run Docker Compose in a container), so be free to set your own aliases there.

### Dockerfile
 - Miscellaneous useful packages (`make`, `vim`, `nano`, `curl`, `wget`, `git` and `software-properties-common` to be able to add PPA)
 - Nginx with a default site configuration for Symfony app (including HTTPS support)
 - PHP 5.6 with FPM and Composer
 - Ruby with `sass`, `less` and `capistrano`
 - Python (could be needed to build some npm dependencies)
 - NodeJS 4 with `nodemon`, `pm2`, `bower`, `gulp` and `grunt`

### docker-entrypoint.sh
This file is the default ENTRYPOINT of the image. It will be executed each time you run this container. This is where you should put all your project specific stuffs that could help you building a perfect Symfony application (e.g. run services, run a Makefile, etc.).

### docker-compose.yml
This file (using Docker Compose) will help you to build a perfect environment for your Symfony app by running and linking several containers the way you want using a single command. 
Keep in mind that this could also be done using many long `docker` commands without the need of `docker-compose` at all.


## How to use?

### First time

 1. Clone this repository in a new folder (let's name it `docker`) **at the root of your Symfony application sources**, with:
`git clone https://github.com/Oliboy50/docker-symfony-vm.git docker`

 2. Go to the new folder `cd docker` and type `docker-machine-dev`
If you followed the [Requirements](#requirements), after a few seconds you will be given access to the VM where you will be able to run `docker` commands

 3. Now that you are in your VM, you can "install" `docker-compose` with: 
`install-docker-compose`
 
 4. Then, again, `cd` to the new folder in your Symfony project (the VM shared your `C:\Users\` (windows) or `/Users/` (mac) folder as `/c/Users/` or `/Users/` --- see [complete reference here](https://github.com/boot2docker/boot2docker#virtualbox-guest-additions)) 
 
 5. Build and run the whole Symfony environment with:
`docker-compose-web` 
(this is just an alias for `docker-compose run --service-ports web`)

 6. If everything worked you should be able to see your Symfony application running in your host browser at 192.168.99.100 (you can check if it is the correct IP by running `docker-machine ip dev` in your host terminal)

When you want to stop coding, `exit` your VM then stop it with `docker-machine stop dev`.

### Second time and more

    # Host terminal
    cd C:\Users\mySymfonyApp\docker
    docker-machine-dev
    # VM terminal
    cd /c/Users/mySymfonyApp/docker
    docker-compose-web


## Get a nice terminal and be able to use Git and many useful UNIX commands on Windows

 1. Install `msysgit` http://msysgit.github.io/ (bottom of the page)

 2. Install `Cmder` http://gooseberrycreative.com/cmder/ (mini version without msysgit)

 3. Add the following directories at the very beginning of the `PATH` environment variable (could be different if you chose a different installation path for msysgit): 
`C:\msysgit\bin;C:\msysgit\mingw\bin;C:\msysgit\cmd;`

 4. I'd also recommend to always run `Cmder` as an Administrator (right click => Properties, etc.). 

**ProTips**: One of the many nice things you can do with Cmder is setting persistent aliases such as `alias cd-docker=cd "C:\path\to\my\sf_project\docker"` =). To view and manage your aliases, edit the file located at `C:\cmder_installation_directory\config\aliases`.


## WTF!? You're using a Docker container as a VM!?
Indeed, I could have split this big image in many smaller images (i.e. PHP5.6 linked with PHP-FPM linked with NGINX linked with NodeJS linked with Ruby, etc.) but I just wanted to keep it really simple. 
This is meant to be a fast deployable development environment nothing else.


## Troubleshooting

### `npm install` fails in my project
This issue comes from your application shared folders, `vboxsf` seems to be not powerful enough to handle so many files.
There are currently 2 workarounds for this kind of issue:

- (Recommended) In your application container, copy the `package.json` file to another (not shared) directory. Run `npm install` there. Then copy back the `node_modules` directory to the root of you application.

or

- Run `npm install` on your host machine (it requires you to have `npm` already installed on your host of course). 

