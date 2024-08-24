{ inputs, outputs, lib, config, pkgs, ... }:
{
  ## AUTO-MOUNT NTFS STORAGE
  fileSystems."/run/media/amon/Storage" =
    { device = "/dev/disk/by-uuid/E070AFBE70AF9A34";
      fsType = "ntfs-3g"; 
      options = [ "rw" "uid=1000"];
    };
}
