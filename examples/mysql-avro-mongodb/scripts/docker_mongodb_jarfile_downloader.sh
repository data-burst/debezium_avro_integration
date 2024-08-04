#!/bin/bash

JAR_FILES_DIR=/kafka/connect
echo "Creating directory: $JAR_FILES_DIR"
mkdir -p $JAR_FILES_DIR

MONGO_KAFKA_CONNECT_VERSION=1.13.0
ARTIFACT="https://github.com/mongodb/mongo-kafka/releases/download/r${MONGO_KAFKA_CONNECT_VERSION}/mongodb-kafka-connect-mongodb-${MONGO_KAFKA_CONNECT_VERSION}.zip"



echo $ARTIFACT
TMP_DIR=/tmp/mongodb
JARFILE_NAME=mongodb-kafka-connect-mongodb-${MONGO_KAFKA_CONNECT_VERSION}
mkdir -p $TMP_DIR
cd $TMP_DIR
curl --show-error --location --progress-bar --remote-name --output-dir $TMP_DIR $ARTIFACT

unzip ${JARFILE_NAME}.zip
cp $JARFILE_NAME/lib/mongo-kafka-connect-${MONGO_KAFKA_CONNECT_VERSION}-confluent.jar ${JAR_FILES_DIR}
rm -rf $TMP_DIR

echo "Done"
