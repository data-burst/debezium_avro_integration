FROM databurst/debezium_avro_integration:latest

WORKDIR /app

COPY scripts/ .
RUN ls -a 
RUN /app/scripts/docker_mongodb_jarfile_downloader.sh
