{ inputs, outputs, lib, config, pkgs, ... }:
{
  ## NVIDIA
  specialisation = { 
    prime-sync.configuration = { 
     system.nixos.tags = ["Nvidia-Prime-Sync"];
     # Nvidia Configuration 
     services.xserver.videoDrivers = [ "nvidia" ]; 
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
  specialisation = { 
    prime-offload.configuration = { 
     system.nixos.tags = ["Nvidia-Prime-Offload"];
     # Nvidia Configuration 
     services.xserver.videoDrivers = [ "nvidia" ]; 
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
	  offload = {
	    enable = lib.mkForce true;
	    enableOffloadCmd = lib.mkForce true;
	  };
          sync.enable = lib.mkForce false;
          nvidiaBusId = "PCI:1:0:0"; 
          intelBusId = "PCI:0:2:0"; 
        };
      };
     };
    };
  };
}

