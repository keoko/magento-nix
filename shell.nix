let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
in
pkgs.mkShell {
  buildInputs = [
    pkgs.bash
    (pkgs.php74.withExtensions ({ enabled, all }: enabled ++ [ all.xsl ]))
    pkgs.php74Packages.composer
    pkgs.nginx
    pkgs.mysql80
  ];
}
