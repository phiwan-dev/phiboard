{
    description = "ergogen dev env";

    #inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";       Uses the cuda driver installed on the system, hence commented out.
    #inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";    Forcing a specific version will likely result in conflicts!

    outputs = { self, nixpkgs }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; config.cudaSupport = true; config.cudnnSupport = true; config.allowUnfree = true; };
    in {
        devShells.${system}.default = pkgs.mkShell {

            buildInputs = with pkgs; [
              ergogen
            ];

            shellHook = ''
              echo loaded ergogen shell
            '';
        };
    };
}

