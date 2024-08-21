{
  description = "My nix packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        packages.my-go = pkgs.callPackage ./packages/my-go { };
        packages.kubernetes = pkgs.callPackage ./packages/kubernetes { };
      }
    );

  # Hint to your binary cache, does not work
  # nixConfig = {
  #   extra-substituters = [
  #     "https://mynix-cache.cachix.org"
  #   ];
  #   extra-trusted-public-keys = [
  #     "mynix-cache.cachix.org-1:tM9YqUHoCWI7FQwQ0vzmp8RY3pRmwylTC/xHCFU6A6E="
  #   ];
  # };
}
