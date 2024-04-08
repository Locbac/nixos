{ inputs, outputs, lib, config, pkgs, ... }:
{
  boot.kernelParams = [ 
  "mitigations=off" 
  ];
  systemd.services.NetworkManager-wait-online.enable = false;
}
