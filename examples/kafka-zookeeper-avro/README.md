
# Kafka ZooKeeper Debezium AVRO Integration

For this example, the quickstart example from the Debezium documentation with AVRO activated is used.

## Run the stack and its services

```bash
docker compose up -d
# If you have older version of Docker Compose (v1), it is required to execute the following command:
# docker-compose up -d
```

## Interacting with the containers

### Connect to MySQL

```bash
docker exec -it mysql_cli bash
exec mysql -h mysql -P 3306 -u root -pdebezium
```

**Note**: the password of the mysql root user is `debezium`.

### Debezium

#### Debezium Version

```bash
curl -H "Accept:application/json" localhost:8083/
```

#### Debezium Connectors list

```bash
curl -H "Accept:application/json" localhost:8083/connectors/
```

#### Debezium sample connector

To add the new connector, execute the following command in your terminal:

```bash
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" localhost:8083/connectors/ -d '{
  "name":"inventory-connector",
  "config":{
    "connector.class":"io.debezium.connector.mysql.MySqlConnector",
    "tasks.max":"1",
    "database.hostname":"mysql",
    "database.port":"3306",
    "database.user":"debezium",
    "database.password":"dbz",
    "database.server.id":"184054",
    "topic.prefix":"dbserver1",
    "database.include.list":"inventory",
    "schema.history.internal.kafka.bootstrap.servers":"kafka:9092",
    "schema.history.internal.kafka.topic":"schemahistory.inventory",
    "key.converter":"io.confluent.connect.avro.AvroConverter",
    "value.converter":"io.confluent.connect.avro.AvroConverter",
    "key.converter.schema.registry.url":"http://schema_registry:8081",
    "value.converter.schema.registry.url":"http://schema_registry:8081"
  }
}'
```

#### Debezium Connector Information

```bash
curl -i -X GET -H "Accept:application/json" localhost:8083/connectors/<connector-name>
# curl -i -X GET -H "Accept:application/json" localhost:8083/connectors/inventory-connector
```
