{
  description = "Fumoctl's Personal Website Dev Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgs = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {
      devShells = forAllSystems (system: {
        default = pkgs.${system}.mkShell {
          packages = with pkgs.${system}; [
            darkhttpd
            imagemagick
          ];

          shellHook = ''
            echo "ᗜˬᗜ Welcome to the Fumoctl website dev shell ᗜˬᗜ"
            echo "You can preview the site by running: darkhttpd . --port 8080"
          '';
        };
      });
    };
}
