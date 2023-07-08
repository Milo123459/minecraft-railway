ARG VERSION=latest
FROM debian:buster-slim

RUN sudo apt-get install build-essential libz-dev jq -y
RUN wget https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-17.0.7/graalvm-community-jdk-17.0.7_linux-x64_bin.tar.gz -O graaltar \
    && mkdir /usr/local/graal \
    && tar -xzf ./graaltar -C /usr/local/graal --strip-components=1 \
    && echo "export PATH=/usr/local/graal/bin:$PATH" >> ~/.bashrc \
    && echo "export JAVA_HOME=/usr/local/graal" >> ~/.bashrc \
    && source ~/.bashrc
RUN curl -fsSL https://tailscale.com/install.sh | sh
RUN sudo apt install jq -y
RUN sudo tailscale up --auth-key ${TAILSCALE_AUTH_KEY}
RUN ["java -version"]