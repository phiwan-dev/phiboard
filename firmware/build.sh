#! /usr/bin/env bash

rm -rf left.uf2 right.uf2

if [ "$1" == "--cached" ] || [ "$1" == "-c" ]; then
  devcontainer exec --workspace-folder ./zmk /bin/bash phiboard-build-cached.sh
else
  devcontainer up --workspace-folder ./zmk
  devcontainer exec --workspace-folder ./zmk /bin/bash phiboard-build.sh
fi

cp zmk/app/build/left/zephyr/zmk.uf2 left.uf2
cp zmk/app/build/right/zephyr/zmk.uf2 right.uf2
