{ config, pkgs, inputs, ... }:
{
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
}
