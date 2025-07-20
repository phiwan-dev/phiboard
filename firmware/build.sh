#! /usr/bin/env bash

if [ "$1" == "--cached" ]; then
    devcontainer exec --workspace-folder ./zmk /bin/bash phiboard-build-cached.sh
else
    devcontainer exec --workspace-folder ./zmk /bin/bash phiboard-build.sh
fi

cp zmk/app/build/left/zephyr/zmk.uf2 left.uf2
cp zmk/app/build/right/zephyr/zmk.uf2 right.uf2
