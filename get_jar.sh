get_build_download() {
  local version="$1"
  local builds_url="https://api.papermc.io/v2/projects/paper/versions/$version/builds"
  local last_build=$(curl -s "$builds_url" | jq -r '.builds | last')
  local name=$(echo "$last_build" | jq -r '.downloads.application.name')
  local build=$(echo "$last_build" | jq -r '.build')
  echo "https://api.papermc.io/v2/projects/paper/versions/$version/builds/$build/downloads/$name"
}

if [ "$MINECRAFT_VERSION" = "latest" ]; then
    last_version=$(curl -s https://api.papermc.io/v2/projects/paper/ | jq -r '.versions | last')
    download_url=$(get_build_download "$last_version")
else
    download_url=$(get_build_download "$MINECRAFT_VERSION")
fi

wget $download_url -O server.jar
