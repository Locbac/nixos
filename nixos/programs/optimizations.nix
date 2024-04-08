{ inputs, outputs, lib, config, pkgs, ... }:
{
  boot.kernelParams = [ "mitigations=off" ];
  systemd.services.NetworkManager-wait-online.service = {
    enable = false;
    restartIfChanged = false;
  };
}
