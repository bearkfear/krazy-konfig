The motivation video: [youtube-video](https://www.youtube.com/watch?v=26jqQoS6SdQ)



[documentation](https://github.com/nix-community/nixos-anywhere/blob/main/docs/quickstart.md)

dockerfile to run nixos-anywhere without using linux on the host;

```sh
docker build -t nixos-anywhere .
docker run -it -v .:/home/config nixos-anywhere bash -c "cd /home/config && nix run github:nix-community/nixos-anywhere --experimental-features 'nix-command flakes' -- --flake .#generic --generate-hardware-config nixos-generate-config ./hardware-configuration.nix nixos@192.168.0.100"
```