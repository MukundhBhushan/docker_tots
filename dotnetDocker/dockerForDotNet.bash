docker build -t aspnet-app:v0.1 .

#to list the images created
docker image

eb application can be accessed.

docker run -d \
  -t -p <port to expose>:<docker port> \
  --name <app name> \
  aspnet-app:v0.1


docker logs app