
# phiboard
in progress, currently in the prototype phase...

<!-- ## Goals -->
<!-- - fully reversible pcb including hotswap sockets, MCU, OLED screen -->
<!-- - wireless using the XIAO BLE as MCU -->
<!-- - low profile (choc kailh) and thin PCB + components -->
<!-- - no visible screws from the top -->
<!-- - no visible seams from the top -->
<!-- - custom graphics and silk screen -->
<!-- - super easy, local zmk development -->



<!-- # Manual additions after Ergogen -->
<!-- Ergogen is used to generate most parts of the PCB. From within the ergogen folder, this can be done using: -->
<!-- ``` -->
<!-- ergogen . && cp output/pcbs/pcb.kicad_pcb ../kicad-prj/ -->
<!-- ``` -->
<!-- However, various smaller modifications as well as the reversible OLED and silkscreen graphics are placed manually by hand. -->
<!-- It is likely that this could be done through ergogen as well, feel free to fork and adjust my config. -->
<!-- All modifications are listed in here: -->
<!-- - Removed silksceens from diodes and modified silksceen for the battery pads. Be careful with this, as it make messing up the diode configuration very easy! -->
<!-- - Wired up MCU and keys in a reversible fashion -->
<!-- - Included reversible OLED --> 
<!-- - Put on silkscreens on front [`porsche-front-big.kicad_mod`](./kicad-prj/graphics.pretty/porsche-front-big.kicad_mod) and back [`porsche-back-big.kicad_mod`](./kicad-prj/graphics.pretty/porsche-back-big.kicad_mod) -->



<!-- # Customize Graphics -->
<!-- In [graphics](./kicad-prj/graphics/) you can find the source images used in this project. -->
<!-- There are two types of graphics. -->
<!-- ### Silkscreen -->
<!-- The silksceen uses the porsche images. -->
<!-- To use a different image you have to open `kicad > image converter`. -->
<!-- In here you can load your desired image, choose an output size and threshold and save it as footprint on F.Silkscreen. -->
<!-- In order for KiCad to detect your custom footprints, you have to save them to a folder with the extension `.pretty` like in [`kicad-prj/graphics.pretty/`](./kicad-prj/graphics.pretty/). -->
<!-- Lastly you need to tell KiCad where to find your footprints. -->
<!-- If you decide to use my project and its `graphics.pretty` folder then KiCad should automatically pick it up through the `fp-lib-table`. -->
<!-- Else, you can specify your `.pretty` path in `Preferences > Manage Footprint Libraries... > Project Specific Libraries`. -->
<!-- ### Solder Images -->
<!-- In the palm of the hand there is a little empty space on the PCB which I decided to use with images which are printed on there using solder. -->
<!-- I got the idea from [this video](https://www.youtube.com/watch?v=ohu4tZ4qov8). -->
<!-- Here is the workflow to put your own images on there: -->
<!-- You will most likely have a .png or .jpg image, which needs to be transformed to .svg. -->
<!-- For this you can use popular online tools like [convertio.co](https://convertio.co/). -->
<!-- Optionally you can try to optimize your svg using [this website](https://optimize.svgomg.net/), although it didn't make much of a difference for me. -->
<!-- Next, we need to transform our svg into an array of points, for which i used [this website](https://shinao.github.io/PathToPoints/). -->
<!-- Lastly, you can replace the point array in [`ergogen/footprints/phi-caps`](./ergogen/footprints/phi-caps.js) for the front side or [`ergogen/footprints/phi-logo`](./ergogen/footprints/phi-logo.js) for the back side. -->



<!-- # Parts -->
<!-- 40 keys, 20 per side -->
<!-- - 40 choc kailh switches -->
<!-- - 40 choc kailh keycaps -->
<!-- - 40 choc hotswap sockets -->
<!-- - 40 smd diodes 1N4148 -->
<!-- - 2 xiao ble -->
<!-- - 2 oled 0.91 inch i2c (optional) -->
<!-- - 2 batteries 3.7v (optional, requres cable otherwise) -->



<!-- # Firmware -->
<!-- Usually ZMK is compiled throug a GitHub actions workflow. However, I prefer to use it locally using a docker devcontainer. The devcontainer is provided by the official ZMK project. -->

<!-- ## Setting up the ZMK docker toolchain -->
<!-- ```bash -->
<!-- nix develop     # or install devcontainer cli otherwise -->
<!-- cd <path-to-phiboard>/firmware -->
<!-- ./setup-zmk.sh  # this may take a while -->
<!-- ``` -->

<!-- ## Compiling the ZMK firmware -->
<!-- ```bash -->
<!-- nix develop     # or install devcontainer cli otherwise -->
<!-- cd <path-to-phiboard>/firmware -->
<!-- ./build.sh  # clean build, is needed the first time -->
<!-- ./build.sh --cached   # faster, if a build has been done before -->
<!-- # the firmware is now located at <path-to-phiboard>/firmware/(left|right).uf2 -->
<!-- ``` -->

<!-- ## Flashing the firmware -->
<!-- - connect mcu with pc -->
<!-- - double press the reset button -->
<!-- - the file explorer should now show a usb media -->
<!-- - copy the corresponding .uf2 firmware to the usb media -->
<!-- - it should now auto-eject and run the new firmware -->


<!-- ## Fighting with ZMK -->
<!-- - spend a lot of time on local toolchain and scripts -->
<!-- - other projects may have their config files in different places -->
<!-- - explain most important files which the user might want to change (and where) -->
<!-- - confusing, overwhelming (at first) -->
<!-- - flash reset firmware to fix problems -->
<!-- - dtsi is "weird" because of the way the matrix is connected (only on prototype) -->
<!-- - right overlay columns are reversed because its mirrored but pcb is non-mirrored -->
<!-- - main half controls layers of secondary half -> perhaps need to flash both sides for keymap to take new changes -->
<!-- - displays have close to 0 documentation at all -->


<!-- # Soldering -->
<!-- - watch a solder intro video if you dont know what you are doing -->
<!-- - the second half will be better -->
<!-- - put solder on the pads, then heat the pads and press components in -->
<!-- - if possible, test connectivity from mcu to front pads -->
<!-- - care for diode direction (on prototype) -->


<!-- # Future fixes (from prototype) -->
<!-- - key spacing? -->
<!-- - different display -->


<!-- # Thanks -->
<!-- - to https://github.com/MvEerd/ergogen/tree/mveerd for ergogen -->
<!-- - to https://flatfootfox.com/ergogen-introduction/ for teaching ergogen -->
<!-- - to https://github.com/Pipshag/goosekb for inspiration on ergogen and zmk -->
<!-- - to https://www.youtube.com/watch?v=ohu4tZ4qov8 for finally making me follow through -->
<!-- - and many, many more! -->
