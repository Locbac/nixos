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
  specialisation = {
    disable-nvidia.configuration = {
      system.nixos.tags = ["Nvidia-Disabled"];
	boot.extraModprobeConfig = ''
	  blacklist nouveau
	  options nouveau modeset=0
	'';
	  
	services.udev.extraRules = ''
	  # Remove NVIDIA USB xHCI Host Controller devices, if present
	  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
	  # Remove NVIDIA USB Type-C UCSI devices, if present
	  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
	  # Remove NVIDIA Audio devices, if present
	  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
	  # Remove NVIDIA VGA/3D controller devices
	  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
	'';
	boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
    };
  };
}

