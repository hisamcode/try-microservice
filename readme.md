```bash
protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative logs.proto

# https://grpc.io/docs/languages/go/quickstart/ then
go get google.golang.org/grpc
go get google.golang.org/protobuf

docker build -f .dockerfile -t hisamcode/service:1.0.0
docker build -f broker-service.dockerfile -t hisamcode/broker-service:1.0.1 .
docker build -f authentication-service.dockerfile -t hisamcode/authentication-service:1.0.0 .
docker build -f logger-service.dockerfile -t hisamcode/logger-service:1.0.0 .
docker build -f mail-service.dockerfile -t hisamcode/mail-service:1.0.0 .
docker build -f listener-service.dockerfile -t hisamcode/listener-service:1.0.0 .
docker build -f frontend-service.dockerfile -t hisamcode/frontend-service:1.0.1 .
docker build -f caddy.dockerfile -t hisamcode/micro-caddy:1.0.2 .

docker push hisamcode/broker-service:1.0.1
docker push hisamcode/authentication-service:1.0.0
docker push hisamcode/logger-service:1.0.0
docker push hisamcode/mail-service:1.0.0
docker push hisamcode/listener-service:1.0.0
docker push hisamcode/frontend-service:1.0.1
docker push hisamcode/micro-caddy:1.0.2

docker swarm init
docker swarm join-token worker
docker swarm join-token manager

docker stack deploy -c swarm.yml myapp

docker service ls
docker service scale myapp_listener-service=3
docker service update --image hisamcode/logger-service:1.0.1 myapp_logger-service
# stop
docker service scale myapp_broker-service=0

docker stack rm myapp
docker swarm leave
docker swarm leave --force

docker node ps
watch docker node ps
```

for scaling caddy service
- glusterFS
- sshfs