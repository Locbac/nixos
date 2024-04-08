{ inputs, outputs, lib, config, pkgs, ... }:
{
  boot.kernelParams = [ "mitigations=off" ];
  systemd.user.units.NetworkManager-wait-online.enable = false;
}
