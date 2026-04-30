#!/usr/bin/env sh
set -eu

mkdir -p "${SERVER_DIR}"
cd "${SERVER_DIR}"

if [ "${EULA}" != "true" ]; then
  echo "You must accept the Minecraft EULA by setting EULA=true."
  echo "See https://aka.ms/MinecraftEULA"
  exit 1
fi

cat > eula.txt <<EOF
eula=${EULA}
EOF

cat > server.properties <<EOF
server-port=${SERVER_PORT}
motd=${MOTD}
level-name=${LEVEL_NAME}
difficulty=${DIFFICULTY}
online-mode=${ONLINE_MODE}
EOF

exec java "-Xms${MEMORY_MIN}" "-Xmx${MEMORY_MAX}" -jar /opt/minecraft/server.jar nogui

