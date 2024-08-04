FROM databurst/debezium_avro_integration:latest

WORKDIR /app

COPY . . 
RUN chmod +x /app/scripts/docker_mongodb_jarfile_downloader.sh && \
    /app/scripts/docker_mongodb_jarfile_downloader.sh

