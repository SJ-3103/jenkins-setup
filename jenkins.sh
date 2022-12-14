#! /bin/bash

echo "Script to create myjenkins and other necessary conatiners(dockerdind)."
docker network create jenkins-net

echo "Container jenkins-dind for docker in docker"
docker run --name the-jenkins-dind --rm --detach \
  --privileged --network jenkins-net --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 \
  docker:dind

echo "Build jenkins image from Dockerfile"
docker build -t myjenkins-image .

echo "Build a jenkins container from myjenkins-image"
docker run --name my-jenkins-container --restart=on-failure --detach \
  --network jenkins-net --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  --publish 8080:8080 --publish 50000:50000 myjenkins-image