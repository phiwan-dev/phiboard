{
    description = "ergogen dev env";
    inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    outputs = { self, nixpkgs }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; config.cudaSupport = true; config.cudnnSupport = true; config.allowUnfree = true; };
    in {
        devShells.${system}.default = pkgs.mkShell {

            buildInputs = with pkgs; [
              ergogen
              librecad  # for 2D outlines
              kicad     # for PCBs
            ];

            shellHook = ''
              export __GLX_VENDOR_LIBRARY_NAME="" # To fix kicad with nvidia drivers

              echo loaded ergogen shell
            '';
        };
    };
}

