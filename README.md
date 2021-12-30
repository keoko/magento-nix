# Magento Development Environment with nix
## Acthung
First time you run `nix-shell` it will download all the nix packages, so it will take some time. Be patient!

## Why
TODO

## Run
TODO
```
NIXPKGS_ALLOW_UNFREE=1 nix-shell
```
The environment variable `NIXPKGS_ALLOW_UNFREE=1` is required by Nix to install elasticsearch7.

## Alternatives
TODO

## Notes
### Varnish
Varnish is disabled by default, as this project is aimed for Magento development. In case you want to enable it, look for the word ENABLE_VARNISH and follow the instructions appended after it.

In order to debug Varnish issues, you could use `varnishlog` with the following command:
```
varnishlog -n $(pwd)/var/varnish/data/
```
