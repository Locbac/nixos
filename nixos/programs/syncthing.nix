{ inputs, outputs, lib, config, pkgs, ... }:
{
  ## SYNCTHING
  services = {
    syncthing = {
        enable = true;
        # FIXME Change Username and Locations
        user = "amon"; 
        dataDir = "/home/amon/syncthing";    # Default folder for new synced folders
        configDir = "/home/amon/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
  };
  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
