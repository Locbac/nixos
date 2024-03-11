{ inputs, outputs, lib, config, pkgs, ... }:
{
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
  environment = {
    systemPackages = with pkgs; [ 
      microcodeIntel
    ];
  };
  services.fstrim.enable = lib.mkForce true;
}
