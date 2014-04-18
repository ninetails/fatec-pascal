sudo docker -d -e lxc

docker build --rm=true -t ninetails/pascal - < Dockerfile

docker run -i -t -v ${PWD}:/root:rw ninetails/pascal /bin/bash
