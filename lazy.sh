LAZYMC=$1

if [ "$LAZYMC" = "true" ]; then
    download_url="https://github.com/timvisee/lazymc/releases/download/v0.2.10/lazymc-v0.2.10-linux-x64"
    apt update -y && apt install wget -y
    wget "$download_url" -O lazymc
    chmod +x lazymc
    mv ./lazymc /usr/local/bin/
    if [ ! -f "/app/lazymc.toml" ]; then
        cd /app
        lazymc config generate
        sed -i 's/command = "java -Xmx1G -Xms1G -jar server.jar --nogui"/command = "java -jar server.jar --nogui"/' lazymc.toml
        sed -i 's/#wake_on_start = false/wake_on_start = true/' lazymc.toml
    fi
fi