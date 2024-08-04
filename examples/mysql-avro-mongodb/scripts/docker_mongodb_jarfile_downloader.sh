#!/bin/bash

JAR_FILES_DIR="/kafka/connect"
echo "Creating directory: $JAR_FILES_DIR"
mkdir -p $JAR_FILES_DIR

ARTIFACTS_URL=(
  # Mongo Connect
  "https://repo1.maven.org/maven2/org/mongodb/kafka/mongo-kafka-connect/${MONGO_KAFKA_CONNECT_VERSION}/mongo-kafka-connect-${MONGO_KAFKA_CONNECT_VERSION}.jar"
)

for ARTIFACT in ${ARTIFACTS_URL[@]}; do
  echo $ARTIFACT
  curl -S --progress-bar --remote-name --output-dir "$JAR_FILES_DIR/" "$ARTIFACT"
done

echo "Done"
