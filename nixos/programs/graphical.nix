{ inputs, outputs, lib, config, pkgs, ... }:
{
  # DISPLAY MANAGERS DESKTOP ENVS ETC
  ## GNOME
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
    ## EXTENSIONS
    environment.systemPackages = with pkgs; [ gnomeExtensions.appindicator ];
  ## KDE PLASMA
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;
  #services.xserver.desktopManager.plasma6.enable = true;

  ## HYPRLAND
  programs.hyprland = {
  	enable = true;
    #enableNvidiaPatches = true;
    xwayland.enable = true;
  };
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
  hardware = {
  	opengl.enable = true;
    nvidia.modesetting.enable = true;
  };
}
