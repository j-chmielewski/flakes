{
  description = "Nix flake for steipete/gogcli";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    gogcli-src = {
      url = "github:steipete/gogcli";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, gogcli-src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.buildGoModule {
          pname = "gogcli";
          version = "unstable";

          src = gogcli-src;

          subPackages = [ "cmd/gog" ];

          vendorHash = "sha256-o92LiyLZ9GTU5ap6kehqqahdLZvroognA8LxCQ17ysg=";
          doCheck = false;

          go = pkgs.go_1_25 or pkgs.go;

          meta = with pkgs.lib; {
            description = "Google-in-your-terminal CLI";
            homepage = "https://github.com/steipete/gogcli";
            license = licenses.mit;
            mainProgram = "gog";
            platforms = platforms.unix;
          };
        };

        apps.default = flake-utils.lib.mkApp {
          drv = self.packages.${system}.default;
        };
      });
}
