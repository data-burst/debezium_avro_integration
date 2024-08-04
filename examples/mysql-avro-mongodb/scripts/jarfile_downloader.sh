#!/bin/bash

ROOT_PROJECT=`git rev-parse --show-toplevel`
JAR_FILES_DIR=$ROOT_PROJECT/jar_files
echo "Creating directory: $JAR_FILES_DIR"
mkdir -p $JAR_FILES_DIR

MONGO_KAFKA_CONNECT_VERSION=1.13.0
ARTIFACTS_URL=(
  # Mongo Connect
  "https://repo1.maven.org/maven2/org/mongodb/kafka/mongo-kafka-connect/${MONGO_KAFKA_CONNECT_VERSION}/mongo-kafka-connect-${MONGO_KAFKA_CONNECT_VERSION}.jar"
)

for ARTIFACT in ${ARTIFACTS_URL[@]}; do
  wget --continue --quiet --show-progress --progress=bar:force --directory-prefix "$JAR_FILES_DIR/" "$ARTIFACT"
done

echo "Done"

