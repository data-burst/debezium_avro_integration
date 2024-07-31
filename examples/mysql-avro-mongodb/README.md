# CDC Example with Debezium, Kafka, and MongoDB

<p align=center>
    <img src="./debezium-mysql-mongo.jpg" alt="CDC Example with Debezium, Kafka, and MongoDB"/>
</p>

This example demonstrates how to set up a Change Data Capture (CDC) pipeline using Debezium, Kafka, and MongoDB. We will capture changes from a MySQL database and sync them to MongoDB collections.

## Prerequisites

- Docker and Docker Compose installed
- Basic knowledge of Docker and Kafka
- MySQL and MongoDB clients installed (optional, for verification)

## Step-by-Step Setup

### 1. Set Up Docker Compose

Create a `docker-compose.yml` file to set up Zookeeper, Kafka, MySQL, MongoDB, Kafka Connect, and Schema Registry. See the file [here](./docker-compose.yaml).

### 2. Start Docker Compose

Run the following command to start all services:

```bash
docker-compose up -d
```

### 3. Configure MySQL Source Connector

Create a mysql-source-connector.json file to configure the MySQL source connector. For detailed configuration options, see the Debezium MySQL Connector documentation. See the file [here](./mysql-source-connector.json).

### 4. Configure MongoDB Sink Connector

Create a mongodb-sink-connector.json file to configure the MongoDB sink connector. For detailed configuration options, see the Debezium MongoDB Connector documentation. See the file [here](./mongodb-sink-connector.json).

Deploy the MongoDB sink connector:

```bash
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" --data @mongodb-sink-connector.json http://localhost:8083/connectors/
```

#### Connection URI Explanation
- **connection.uri:** mongodb://<mongodb_user>:<mongodb_pass>@<mongodb_host>:<mongodb_port>
- **mongodb_user:** MongoDB username (e.g., root)
- **mongodb_pass:** MongoDB password (e.g., example)
- **mongodb_host:** Hostname of the MongoDB server (e.g., mongodb)
- **mongodb_port:** Port number of the MongoDB server (e.g., 27017)

### 5. Verify Data in MongoDB

Connect to MongoDB and verify that data is being replicated.
