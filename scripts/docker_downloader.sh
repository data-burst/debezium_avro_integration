#!/bin/bash
VERSION=7.5.3
echo "Debezium artifacts version: $VERSION"

JAR_FILES_DIR="/kafka/plugins"
echo "Creating directory: $JAR_FILES_DIR"
mkdir -p $JAR_FILES_DIR

DEBEZIUM_ARTIFACTS=(
  "common-config"
  "common-utils"
  "kafka-avro-serializer"
  "kafka-connect-avro-converter"
  "kafka-connect-avro-data"
  "kafka-schema-registry-client"
  "kafka-schema-serializer"
)

for ARTIFACT in ${DEBEZIUM_ARTIFACTS[@]}; do
  echo $ARTIFACT
  curl -S --progress-bar --remote-name --output-dir "$JAR_FILES_DIR/" "https://packages.confluent.io/maven/io/confluent/$ARTIFACT/$VERSION/$ARTIFACT-$VERSION.jar"
done

OTHER_ARTIFACTS_URL=(
  "https://repo1.maven.org/maven2/org/apache/avro/avro/1.11.3/avro-1.11.3.jar"
  "https://repo1.maven.org/maven2/org/apache/commons/commons-compress/1.21/commons-compress-1.21.jar"
  "https://repo1.maven.org/maven2/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar"
  "https://repo1.maven.org/maven2/com/google/guava/guava/31.0.1-jre/guava-31.0.1-jre.jar"
  "https://repo1.maven.org/maven2/com/eclipsesource/minimal-json/minimal-json/0.9.5/minimal-json-0.9.5.jar"
  "https://repo1.maven.org/maven2/com/google/re2j/re2j/1.6/re2j-1.6.jar"
  "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/1.7.36/slf4j-api-1.7.36.jar"
  "https://repo1.maven.org/maven2/org/yaml/snakeyaml/2.0/snakeyaml-2.0.jar"
  "https://repo1.maven.org/maven2/io/swagger/core/v3/swagger-annotations/2.1.10/swagger-annotations-2.1.10.jar"
  # jackson
  "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.14.2/jackson-databind-2.14.2.jar"
  "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.14.2/jackson-core-2.14.2.jar"
  "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.14.2/jackson-annotations-2.14.2.jar"
  "https://repo1.maven.org/maven2/com/fasterxml/jackson/dataformat/jackson-dataformat-csv/2.14.2/jackson-dataformat-csv-2.14.2.jar"
  # log redactor
  "https://repo1.maven.org/maven2/io/confluent/logredactor/1.0.12/logredactor-1.0.12.jar"
  "https://repo1.maven.org/maven2/io/confluent/logredactor-metrics/1.0.12/logredactor-metrics-1.0.12.jar"
)
for ARTIFACT in ${OTHER_ARTIFACTS_URL[@]}; do
  echo $ARTIFACT
  curl -S --progress-bar --remote-name --output-dir "$JAR_FILES_DIR/" "$ARTIFACT"
done

echo "Done"
