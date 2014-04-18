sudo docker -d -e lxc

docker build -t ninetails/pascal - < Dockerfile

docker run -i -t -v ${PWD}:/root:ro ninetails/pascal /bin/bash
