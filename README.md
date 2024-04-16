Pull Docker Image
---
`docker pull ubuntu:22.04`

`docker pull centos:8`

Build Docker Image
---
`docker build -f <dockerfile> -t <image_id> --no-cache --force-rm .`

Run Docker Image
---
Run a docker image in a container: `docker run --name <container_name> --user root --rm -it -v ${PWD}:/home/test/tmp <image_id> /bin/bash`

Connect to the existing docker container in another terminal: `docker exec -it <container_name> /bin/bash`

Other Docker Commands
---
<pre>
Create a network bridge : docker network create <bridge_name>
List docker images      : docker image list
Remove docker image     : docker image rm <image>
Clear build cache       : docker builder prune
Show containers         : docker ps
</pre>
