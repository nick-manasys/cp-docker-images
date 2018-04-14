#
#
#
echo https://docs.confluent.io/current/installation/docker/docs/quickstart.html

docker-compose up -d
docker-compose ps
docker-compose logs zookeeper
docker-compose logs zookeeper | grep 0.0.0.0
docker-compose logs zookeeper | grep 0.0.0.0:32181
docker-compose logs kafka | grep -i started
docker-compose ps
docker-compose exec kafka  kafka-topics --create --topic foo --partitions 1 --replication-factor 1 --if-not-exists --zookeeper localhost:32181
docker-compose exec kafka    kafka-topics --describe --topic foo --zookeeper localhost:32181
docker-compose exec kafka    bash -c "seq 42 | kafka-console-producer --request-required-acks 1 --broker-list localhost:29092 --topic foo && echo 'Produced 42 messages.'"
docker-compose exec kafka    kafka-console-consumer --bootstrap-server localhost:29092 --topic foo --from-beginning --max-messages 42
docker-compose down
