
# phiboard
in progress...

## Goals
- fully reversible pcb including hotswap sockets, MCU, OLED screen
- wireless using the XIAO BLE as MCU
- low profile (choc kailh) and thin PCB + components
- no visible screws from the top
- no visible seams from the top
- custom graphics and silk screen


# Manual additions after Ergogen
Ergogen is used to generate most parts of the PCB. This can be done using:
```
ergogen . && cp output/pcbs/pcb.kicad_pcb kicad-prj/
```
However, various smaller modifications as well as the reversible OLED and silkscreen graphics are placed manually by hand.
It is likely that this could be done through ergogen as well, feel free to fork and adjust my config.
All modifications are listed in here:
- Removed silksceens from diodes and modified silksceen for the battery pads. Be careful with this, as it make messing up the diode configuration very easy!
- Wired up MCU and keys in a reversible fashion
- Included reversible OLED 
- Put on silkscreens on front [`porsche-front-big.kicad_mod`](./kicad-prj/graphics.pretty/porsche-front-big.kicad_mod) and back [`porsche-back-big.kicad_mod`](./kicad-prj/graphics.pretty/porsche-back-big.kicad_mod)


# Customize Graphics
In [graphics](./graphics/) you can find the source images used in this project.
There are two types of graphics.
### Silkscreen
The silksceen uses the porsche images.
To use a different image you have to open `kicad > image converter`.
In here you can load your desired image, choose an output size and threshold and save it as footprint on F.Silkscreen.
In order for KiCad to detect your custom footprints, you have to save them to a folder with the extension `.pretty` like in [`kicad-prj/graphics.pretty/`](./kicad-prj/graphics.pretty/).
Lastly you need to tell KiCad where to find your footprints.
If you decide to use my project and its `graphics.pretty` folder then KiCad should automatically pick it up through the `fp-lib-table`.
Else, you can specify your `.pretty` path in `Preferences > Manage Footprint Libraries... > Project Specific Libraries`.
### Solder Images
In the palm of the hand there is a little empty space on the PCB which I decided to use with images which are printed on there using solder.
I got the idea from [this video](https://www.youtube.com/watch?v=ohu4tZ4qov8).
Here is the workflow to put your own images on there:
You will most likely have a .png or .jpg image, which needs to be transformed to .svg.
For this you can use popular online tools like [convertio.co](https://convertio.co/).
Optionally you can try to optimize your svg using [this website](https://optimize.svgomg.net/), although it didn't make much of a difference for me.
Next, we need to transform our svg into an array of points, for which i used [this website](https://shinao.github.io/PathToPoints/).
Lastly, you can replace the point array in [`footprints/phi-caps`](./footprints/phi-caps.js) for the front side or [`footprints/phi-logo`](./footprints/phi-logo.js) for the back side.


# Parts
40 keys, 20 per side
- 40 choc kailh switches
- 40 choc kailh keycaps
- 40 choc hotswap sockets
- 40 smd diodes 1N4148
- 2 xiao ble
- 2 oled 0.91 inch i2c (optional)
- 2 batteries 3.7v (optional, requres cable otherwise)

# Firmware
## Using ZMK locally using docker
For now, this is the tutorial to get the goosekb to work.
```bash
cd <path-to-goosekb>
docker volume create --driver local -o o=bind -o type=none -o device="<absolute-path-to-goosekb>/config/" zmk-config  # enter absolute path
git clone https://github.com/zmkfirmware/zmk.git firmware/zmk
nix shell nixpkgs#devcontainer  # or install devcontainer otherwise
devcontainer up --workspace-folder firmware/zmk
docker ps -a    # get zmk container name
docker exec -it <zmk-container-name> /bin/bash
# now from within container
cd /workspaces/zmk
west init -l app/
west update
# actually build the firmware
cd app
rm -rf build/
west build -p -d build/left -b seeeduino_xiao_ble -- -DSHIELD=goose_left -DZMK_CONFIG="/workspaces/zmk-config"
west build -p -d build/right -b seeeduino_xiao_ble -- -DSHIELD=goose_right -DZMK_CONFIG="/workspaces/zmk-config"
cp build/left/zephyr/zmk.uf2 build/left.uf2
cp build/right/zephyr/zmk.uf2 build/right.uf2
# connect mcu with pc
# double press the reset button
# the file explorer should now show a usb media
# copy the corresponding .uf2 firmware to the usb media
# it should now auto-eject and run the new firmware
```

# Thanks
- to https://github.com/MvEerd/ergogen/tree/mveerd for ergogen
- to https://flatfootfox.com/ergogen-introduction/ for teaching ergogen
- to https://github.com/Pipshag/goosekb for inspiration
- to https://www.youtube.com/watch?v=ohu4tZ4qov8 for finally making me follow through
- and many, many more!
