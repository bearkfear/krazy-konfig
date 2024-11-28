This `disk-config.nix` file will define the disk layout for the disko tool, which is used by nixos-anywhere to partition, format, and mount the disks.


This configuration sets up a standard GPT (GUID Partition Table) that is compatible with both EFI and BIOS systems and mounts the disk as /dev/sda. You may need to adjust /dev/sda to match the correct disk on your machine. To identify the disk, run the lsblk command and replace sda with the actual disk name.

For example, on this machine, we would select nvme0n1 as the disk:

```sh
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
nvme0n1     259:0    0  1.8T  0 disk
```

If this setup does not match your requirements, you can choose an example that better suits your disk layout from the [disko examples](https://github.com/nix-community/disko/tree/master/example). For more detailed information, refer to the [disko documentation](https://github.com/nix-community/disko).