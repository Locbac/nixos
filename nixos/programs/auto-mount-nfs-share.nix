{ inputs, outputs, lib, config, pkgs, ... }:
{
  fileSystems."/home/amon/windows-nfs" = 
  {
    device = "192.168.0.101:/OldNerd";
    fsType = "nfs";
    options = [ "noauto" ];
  };
}
