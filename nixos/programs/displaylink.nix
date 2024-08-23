{ config, pkgs, inputs, ... }:
{
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
  environment.systemPackages = with pkgs; [
  	displaylink
  ];
}
