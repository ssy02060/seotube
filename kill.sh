sudo docker-compose kill
sudo docker rm -vf $(docker ps -aq)
sudo docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
