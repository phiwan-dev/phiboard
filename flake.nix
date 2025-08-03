{
    description = "dev env for development of the phiboard keyboard";
    inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    outputs = { self, nixpkgs }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    in {
        devShells.${system}.default = pkgs.mkShell {

            buildInputs = with pkgs; [
                ergogen
                librecad  # for 2D outlines

                kicad     # for PCBs

	            devcontainer  # for zmk
            ];

            shellHook = ''
              export __GLX_VENDOR_LIBRARY_NAME="" # To fix kicad with nvidia drivers

              echo loaded phiboard shell
            '';
        };
    };
}

