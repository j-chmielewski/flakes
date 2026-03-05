{
  description = "LobsterBoard npm app package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.buildNpmPackage {
            pname = "lobster-board";
            version = "git";

            src = pkgs.fetchFromGitHub {
              owner = "Curbob";
              repo = "LobsterBoard";
              rev = "main";
              hash = pkgs.lib.fakeHash;
            };

            npmDepsHash = pkgs.lib.fakeHash;
          };
        });
    };
}
