let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  php74' = pkgs.php74.buildEnv { 
    extensions = { enabled, all }: enabled ++ [ all.xsl all.opcache all.xdebug ];
    extraConfig = "memory_limit = -1";
  };
  rabbitmq-server' = pkgs.rabbitmq-server.override {
    elixir = pkgs.elixir_1_12;
  };
  composer' = pkgs.php74Packages.composer.override {
    php = php74';
  };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.bash
    # gettext required to install envsubst
    pkgs.gettext
    # inetutils required to install telnet and others
    pkgs.inetutils
    pkgs.vim
    pkgs.hivemind
    php74'
    composer'
    pkgs.nginx
    pkgs.mysql80
    pkgs.elasticsearch7
    pkgs.redis
    pkgs.varnish60
    rabbitmq-server'
    pkgs.mailhog
    pkgs.selenium-server-standalone
    pkgs.chromedriver
  ];
}
