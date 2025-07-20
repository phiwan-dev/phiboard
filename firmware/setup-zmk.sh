#! /usr/bin/env bash

# clean up any existing containers or volumes
# ignore errors if they do not exist
docker container stop zmk-devcontainer || true
docker container rm zmk-devcontainer || true
docker volume rm zmk-config || true
if [ -d ./zmk ]; then
    echo zmk directory already exists, removing it...
    sudo rm -rf zmk
fi
git clone https://github.com/zmkfirmware/zmk.git

# add naming the docker container and run it
cp zmk/.devcontainer/devcontainer.json zmk/.devcontainer/devcontainer.json.bak
sed -i 's#"runArgs": \["--security-opt", "label=disable"\],#"runArgs": \["--security-opt", "label=disable", "--name", "zmk-devcontainer"\],#g' zmk/.devcontainer/devcontainer.json
docker volume create --driver local -o o=bind -o type=none -o device="$(pwd)/zmk-config" zmk-config

devcontainer up --workspace-folder ./zmk
devcontainer exec --workspace-folder ./zmk west init -l ./app/
devcontainer exec --workspace-folder ./zmk west update

# create a build scripts for the zmk app
echo "
#! /bin/bash
echo doing a clean build...
(
    rm -rf build/
    cd app/
    west build -p -d build/left -b seeeduino_xiao_ble -- -DSHIELD=phiboard_left -DZMK_CONFIG="/workspaces/zmk-config"
    west build -p -d build/right -b seeeduino_xiao_ble -- -DSHIELD=phiboard_right -DZMK_CONFIG="/workspaces/zmk-config"
)
" > zmk/phiboard-build.sh
chmod +x zmk/phiboard-build.sh

echo "
#! /bin/bash
echo doing a successive build...
(
    cd app/
    west build -d build/left
    west build -d build/right
)
" > zmk/phiboard-build-cached.sh
chmod +x zmk/phiboard-build-cached.sh
