{
  modulesPath,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  services.openssh.enable = true;

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    # change this to your ssh key
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD1Ls2/4TEEiwe/16JOuwjkWylpJTMQnDMm1Ne+Dh2zO34EE26Xum2o+5+9cYaJB8NgmIc1rzhxJOF3eumzRZdyeqsH+cQyNZ8dMkWsAatApz/ZOKOJOx/huNfuM9zb5jZ6aG9Yn5rzX1ce/m+RM/DUk48QUmDfVZusL2QyaLfOvEIIS0OFxoBCLdctdspuoCmLi8ZNZaFUfhtBE8zKG984G7dmY1el5wxqQE0LFFj2k3XOir1p86QB5cP/TMnWgokCZ7YdUOGfQzUyXbBk6ObxoRWKb7y4yowuqjZR05cKeoEbWpe2ciTCQRjdjHBy9l1L+YbvD+kRejn/HydASI/70sPwdDG0rbFgflm/qaqPK/6zHcWcq8B/TWJSaQzbIHIEdUEUjmAE1w7hqbkUGKbc6682ZmzsN+TQsZBs7/cSxiAxGQ5Ay2r7dDAhbrB0FifX3Xw1U2NEkqh6d6k6wYx8LFIK2rrZ8t5A9tZefh+hzvzN2XxO1Hghrr15LHIVtq0= enric@avell"
  ];

  networking.firewall.allowedTCPPorts = [
    6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
    # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
    # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
  ];
  networking.firewall.allowedUDPPorts = [
    8472 # k3s, flannel: required if using multi-node for inter-node networking
  ];
  services.k3s.enable = true;
  services.k3s.role = "server";
  services.k3s.extraFlags = toString [
    # "--debug" # Optionally add additional args to k3s
  ];

  system.stateVersion = "24.05";
}