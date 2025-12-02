{
    description = "dev env for development of the phiboard keyboard";
    inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    outputs = { self, nixpkgs }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    in {
        devShells.${system}.default = pkgs.mkShell {

            buildInputs = with pkgs; [
                typst

                devcontainer  # for zmk
            ];

            shellHook = ''
              echo loaded phiboard shell
            '';
        };
    };
}

