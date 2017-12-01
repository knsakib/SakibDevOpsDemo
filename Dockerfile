# use a node base image
FROM node:7-onbuild

# set maintainer
LABEL maintainer "knsakib@gmail.com"

# set a health check
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:8000 || exit 1

# tell docker what port to expose
EXPOSE 8000

DOCKER_SOCKET=/var/run/docker.sock
DOCKER_GROUP=docker
JENKINS_USER=jenkins

if [ -S ${DOCKER_SOCKET} ]; then
DOCKER_GID=$(stat -c '%g' ${DOCKER_SOCKET})
sudo groupadd -for -g ${DOCKER_GID} ${DOCKER_GROUP}
sudo usermod -aG ${DOCKER_GROUP} ${JENKINS_USER}
fi

# Start Jenkins service
sudo service jenkins restart
