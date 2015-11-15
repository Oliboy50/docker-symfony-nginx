#!/bin/bash
set -e

# create machine if not already exist, then start it
docker-machine create --driver="virtualbox" --virtualbox-memory="3072" dev
docker-machine start dev

# set environment variables for this machine
eval "$(docker-machine env dev)"





#
# DOCKER ALIASES
#

# alias dstop-all='docker stop $(docker ps -q)'
docker-machine ssh dev "echo \"alias dstop-all='docker stop \$(docker ps -q)'\" >> ~/.ashrc"

# alias drm-all='docker rm $(docker ps -q --filter status=exited)'
docker-machine ssh dev "echo \"alias drm-all='docker rm \$(docker ps -q --filter status=exited)'\" >> ~/.ashrc"

# alias drmi-notag='docker rmi $(docker images -q --filter dangling=true)'
docker-machine ssh dev "echo \"alias drmi-notag='docker rmi \$(docker images -q --filter dangling=true)'\" >> ~/.ashrc"

# alias dclean-volumes='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock:ro -v /var/lib/docker:/var/lib/docker martin/docker-cleanup-volumes'
docker-machine ssh dev "echo \"alias dclean-volumes='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock:ro -v /var/lib/docker:/var/lib/docker martin/docker-cleanup-volumes'\" >> ~/.ashrc"

# alias install-docker-compose='docker build -t docker-compose github.com/docker/compose'
docker-machine ssh dev "echo \"alias install-docker-compose='docker build -t docker-compose github.com/docker/compose'\" >> ~/.ashrc"

# alias docker-compose='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):$(pwd) -w $(pwd) docker-compose'
docker-machine ssh dev "echo \"alias docker-compose='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v \$(pwd):\$(pwd) -w \$(pwd) docker-compose'\" >> ~/.ashrc"





#
# PERSONAL ALIASES
#

# alias docker-compose-web='docker-compose run --service-ports web'
docker-machine ssh dev "echo \"alias docker-compose-web='docker-compose run --service-ports web'\" >> ~/.ashrc"

# alias cd-compose='cd /c/Users/path/to/docker/compose/yml'
# docker-machine ssh dev "echo \"alias cd-compose='cd /c/Users/path/to/docker/compose/yml'\" >> ~/.ashrc"





# connect to the machine
docker-machine ssh dev
