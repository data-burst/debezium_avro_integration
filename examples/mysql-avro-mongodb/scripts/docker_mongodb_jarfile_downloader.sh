#!/bin/bash

JAR_FILES_DIR=/tmp/connect
echo "Creating directory: $JAR_FILES_DIR"
mkdir -p $JAR_FILES_DIR

MONGO_KAFKA_CONNECT_VERSION=1.13.0
MONGO_KAFKA_CONNECT_DIR_NAME=mongodb-kafka-connect-mongodb-${MONGO_KAFKA_CONNECT_VERSION}
ARTIFACT="https://github.com/mongodb/mongo-kafka/releases/download/r${MONGO_KAFKA_CONNECT_VERSION}/${MONGO_KAFKA_CONNECT_DIR_NAME}.zip"

echo $ARTIFACT
TMP_DIR=/tmp/mongodb
mkdir -p $TMP_DIR
cd $TMP_DIR
curl --show-error --location --progress-bar --remote-name --output-dir $TMP_DIR $ARTIFACT

unzip -j ${MONGO_KAFKA_CONNECT_DIR_NAME}.zip
cp mongo-kafka-connect-${MONGO_KAFKA_CONNECT_VERSION}-confluent.jar ${JAR_FILES_DIR}
rm -rf $TMP_DIR

echo "Done"