ARG MINECRAFT_VERSION=latest
ARG EULA=false
ARG LAZYMC=true
FROM alpine:latest
ARG EULA
ARG MINECRAFT_VERSION
COPY get_jar.sh /get_jar.sh
RUN apk add jq curl wget openrc
RUN MINECRAFT_VERSION=$MINECRAFT_VERSION ./get_jar.sh

FROM azul/zulu-openjdk:17
WORKDIR /app
ARG EULA
ARG LAZYMC
COPY --from=0 ./server.jar /app/server.jar
COPY start.sh /start.sh
COPY lazy.sh /lazy.sh
RUN LAZYMC=$LAZYMC /lazy.sh

RUN echo -e "#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://aka.ms/MinecraftEULA).\n#Mon Jul 10 14:59:36 GMT 2023\neula=${EULA}" > eula.txt
RUN echo -e 'enable-jmx-monitoring=false\nrcon.port=25575\nlevel-seed=\ngamemode=survival\nenable-command-block=false\nenable-query=false\ngenerator-settings={}\nenforce-secure-profile=true\nlevel-name=world\nmotd=A Minecraft Server\nquery.port=25565\npvp=true\ngenerate-structures=true\nmax-chained-neighbor-updates=1000000\ndifficulty=easy\nnetwork-compression-threshold=256\nmax-tick-time=60000\nrequire-resource-pack=false\nuse-native-transport=true\nmax-players=20\nonline-mode=true\nenable-status=true\nallow-flight=false\ninitial-disabled-packs=\nbroadcast-rcon-to-ops=true\nview-distance=10\nserver-ip=\nresource-pack-prompt=\nallow-nether=true\nserver-port=25566\nenable-rcon=false\nsync-chunk-writes=true\nop-permission-level=4\nprevent-proxy-connections=false\nhide-online-players=false\nresource-pack=\nentity-broadcast-range-percentage=100\nsimulation-distance=10\nrcon.password=\nplayer-idle-timeout=0\nforce-gamemode=false\nrate-limit=0\nhardcore=false\nwhite-list=false\nbroadcast-console-to-ops=true\nspawn-npcs=true\nspawn-animals=true\nfunction-permission-level=2\ninitial-enabled-packs=vanilla\nlevel-type=minecraft:normal\ntext-filtering-config=\nspawn-monsters=true\nenforce-whitelist=false\nspawn-protection=16\nresource-pack-sha1=\nmax-world-size=29999984' > server.properties

ENTRYPOINT /start.sh $LAZYMC
# RUN bash