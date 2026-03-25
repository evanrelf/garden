{ inputs, ... }:

{
  systems = [ "aarch64-darwin" "aarch64-linux" "x86_64-linux" ];

  perSystem = { pkgs, system, ... }: {
    _module.args.pkgs =
      import inputs.nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

    legacyPackages = pkgs;
  };
}
