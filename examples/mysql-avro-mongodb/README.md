# CDC Example with Debezium, Kafka, and MongoDB

This example demonstrates how to set up a Change Data Capture (CDC) pipeline using Debezium, Kafka, and MongoDB. We will capture changes from a MySQL database and sync them to MongoDB collections.

## Prerequisites

- Docker and Docker Compose installed
- Basic knowledge of Docker and Kafka
- MySQL and MongoDB clients installed (optional, for verification)

## Step-by-Step Setup

### 1. Set Up Docker Compose

Create a `docker-compose.yml` file with the following content to set up Zookeeper, Kafka, MySQL, MongoDB, Kafka Connect, and Schema Registry:

```bash
version: '3'

services:
  zookeeper:
    image: quay.io/debezium/zookeeper:2.5
    container_name: zookeeper
    ports:
      - 2181:2181

  kafka:
    image: quay.io/debezium/kafka:2.5
    container_name: kafka
    ports:
      - 9092:9092
    environment:
      ZOOKEEPER_CONNECT: zookeeper:2181
    depends_on:
      - zookeeper

  mysql:
    image: quay.io/debezium/example-mysql:2.5
    container_name: mysql
    ports:
      - 3306:3306
    environment:
      MYSQL_ROOT_PASSWORD: debezium
      MYSQL_USER: mysqluser
      MYSQL_PASSWORD: mysqlpw

  connect:
    image: quay.io/debezium/connect:2.5
    container_name: connect
    ports:
      - 8083:8083
    environment:
      GROUP_ID: 1
      CONFIG_STORAGE_TOPIC: my_connect_configs
      OFFSET_STORAGE_TOPIC: my_connect_offsets
      STATUS_STORAGE_TOPIC: my_connect_statuses
      BOOTSTRAP_SERVERS: kafka:9092
      KEY_CONVERTER: io.confluent.connect.avro.AvroConverter
      VALUE_CONVERTER: io.confluent.connect.avro.AvroConverter
      CONNECT_KEY_CONVERTER_SCHEMA_REGISTRY_URL: http://schema_registry:8081
      CONNECT_VALUE_CONVERTER_SCHEMA_REGISTRY_URL: http://schema_registry:8081
      KAFKA_CONNECT_PLUGINS_DIR: /kafka/connect
    volumes:
      - ../../jar_files:/kafka/connect/avro_jar_files
    depends_on:
      - kafka
      - schema_registry
      - mysql

  schema_registry:
    image: confluentinc/cp-schema-registry:7.1.10
    container_name: schema_registry
    ports:
      - 8081:8081
    environment:
      SCHEMA_REGISTRY_KAFKASTORE_CONNECTION_URL: zookeeper:2181
      SCHEMA_REGISTRY_KAFKASTORE_BOOTSTRAP_SERVERS: PLAINTEXT://kafka:9092

  mongodb:
    image: mongo:7.0.12
    container_name: mongodb
    ports:
      - 27017:27017
    environment:
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: example
```

### 2. Start Docker Compose

Run the following command to start all services:

```bash
docker-compose up -d
```

### 3. Configure MySQL Source Connector

Create a `mysql-source-connector.json` file with the following content to configure the MySQL source connector:

```bash
{
  "name": "inventory-connector",
  "config": {
    "connector.class": "io.debezium.connector.mysql.MySqlConnector",
    "tasks.max": "1",
    "database.hostname": "mysql",
    "database.port": "3306",
    "database.user": "debezium",
    "database.password": "dbz",
    "database.server.id": "184054",
    "topic.prefix": "dbserver1",
    "database.include.list": "inventory",
    "schema.history.internal.kafka.bootstrap.servers": "kafka:9092",
    "schema.history.internal.kafka.topic": "schemahistory.inventory",
    "snapshot.mode": "initial"
  }
}
```

### 4. Configure MongoDB Sink Connector

Create a `mongodb-sink-connector.json` file with the following content to configure the MongoDB sink connector:

```bash
{
  "name": "mongodb-sink-connector",
  "config": {
    "connector.class": "com.mongodb.kafka.connect.MongoSinkConnector",
    "tasks.max": "1",
    "topics.regex": "dbserver1.inventory.(.*)",
    "connection.uri": "mongodb://root:example@mongodb:27017/?authSource=admin",
    "database": "inventory",
    "collection": "${topic}",
    "key.converter": "io.confluent.connect.avro.AvroConverter",
    "key.converter.schema.registry.url": "http://schema_registry:8081",
    "value.converter": "io.confluent.connect.avro.AvroConverter",
    "value.converter.schema.registry.url": "http://schema_registry:8081",
    "transforms": "unwrap",
    "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
    "transforms.unwrap.add.headers": "db,op,ts_ms",
    "errors.tolerance": "all",
    "errors.deadletterqueue.topic.name": "mongodb-sink-errors",
    "errors.deadletterqueue.context.headers.enable": "true",
    "errors.deadletterqueue.topic.replication.factor": "1"
  }
}
```

Deploy the MongoDB sink connector:

```bash
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" --data @mongodb-sink-connector.json http://localhost:8083/connectors/
```

### 5. Verify Data in MongoDB

Connect to MongoDB and verify that data is being replicated.

## Conclusion

This example demonstrates how to set up a CDC pipeline using Debezium, Kafka, and MongoDB. By following these steps, you can capture changes from a MySQL database and sync them to MongoDB collections. For further customization and advanced configurations, refer to the official documentation of Debezium, Kafka, and MongoDB.


