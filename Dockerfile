ARG DEBEZIUM_VERSION=2.5
ARG DEBEZIUM_IMAGE=quay.io/debezium/connect:${DEBEZIUM_VERSION}
FROM ${DEBEZIUM_IMAGE} 

WORKDIR /app
COPY . .
RUN /app/scripts/docker_downloader.sh

