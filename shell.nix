let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  php74' = pkgs.php74.buildEnv { 
    extensions = { enabled, all }: enabled ++ [ all.xsl ];
    extraConfig = "memory_limit = -1"; };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.bash
    php74'
    pkgs.php74Packages.composer
    pkgs.nginx
    pkgs.mysql80
  ];
}
