{ config, inputs, lib, ... }:

{
  systems = [ "aarch64-darwin" "aarch64-linux" "x86_64-linux" ];

  flake.overlays.default = lib.composeManyExtensions [
    (final: prev: config.flake.packages.${prev.stdenv.hostPlatform.system})
  ];

  perSystem = { pkgs, system, ... }: {
    _module.args.pkgs =
      import inputs.nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [ config.flake.overlays.default ];
      };

    legacyPackages = pkgs;
  };
}
