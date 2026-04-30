FROM eclipse-temurin:21-jre

ENV SERVER_DIR=/data \
    MEMORY_MIN=1G \
    MEMORY_MAX=2G \
    EULA=false \
    SERVER_PORT=25565 \
    ONLINE_MODE=true \
    DIFFICULTY=easy \
    MOTD="Docker Minecraft Server" \
    LEVEL_NAME=world

WORKDIR /opt/minecraft

COPY server.jar /opt/minecraft/server.jar
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 25565

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["java", "-jar", "/opt/minecraft/server.jar", "nogui"]
