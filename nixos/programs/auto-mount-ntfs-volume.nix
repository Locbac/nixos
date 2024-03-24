{ inputs, outputs, lib, config, pkgs, ... }:
{
  ## AUTO-MOUNT NTFS STORAGE
  fileSystems."/run/media/amon/Storage" =
    { device = "/dev/disk/by-uuid/E6CCD727CCD6F0B3";
      fsType = "ntfs-3g"; 
      options = [ "rw" "uid=1000"];
    };
}
