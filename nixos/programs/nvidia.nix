{ inputs, outputs, lib, config, pkgs, ... }:
{
  ## NVIDIA
  specialisation = { 
    nvidia.configuration = { 
     # Nvidia Configuration 
     services.xserver.videoDrivers = [ "nvidia" ]; 
     environment.systemPackages = [ nvidia-offload ];
     nvidiaSettings = true;
     hardware = {
      opengl.enable = true;
      nvidia = {
        powerManagement = {
          enable = lib.mkDefault true;
          #finegrained = lib.mkDefault true;
        };
        package = config.boot.kernelPackages.nvidiaPackages.stable; 
        modesetting.enable = true; 
        prime = { 
          sync.enable = true; 
          nvidiaBusId = "PCI:1:0:0"; 
          intelBusId = "PCI:0:2:0"; 
        };
      };
     };
    };
  };
}
