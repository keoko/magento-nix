# Windows10 Installation
These are the steps I followed to install this project in Windows10 WSL2 (Alpine).

- [Install WSL2](https://docs.microsoft.com/en-us/windows/wsl/install).
During this step I had the error  "WslRegisterDistribution failed with error: 0xffffffff" when trying to run `wsl`. Read this [stackoverflow response](https://stackoverflow.com/questions/64191759/wslregisterdistribution-failed-with-error-0xffffffff) to fix it.
- Download [Alpine distribution](https://www.microsoft.com/en-us/p/alpine-wsl/9p804crf0395) for Windows10.
- Start `alpine` from a windows terminal.
```
alpine
```
- Install required packages to download magento-nix repository.
```
su -c 'apk update; apk upgrade; apk add curl xz git;'
cd magento-nix
. /home/keoko/.nix-profile/etc/profile.d/nix.sh
```
- [Install Nix](https://nixos.org/guides/install-nix.html).
```
su -c 'mkdir -m 0755 /nix && chown keoko /nix'
curl -L https://nixos.org/nix/install | sh
```
- Clone this repository.
```
git clone https://github.com/keoko/magento-nix
```
- Follow section `Install` of the [README](../README.md).
