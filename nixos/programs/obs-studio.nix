{ inputs, outputs, lib, config, pkgs, ... }:
{
environment.systemPackages = [
  pkgs.obs-studio
  (pkgs.wrapOBS {
    plugins = with pkgs.obs-studio-plugins; [
      #wlrobs
      #obs-backgroundremoval
      obs-pipewire-audio-capture
      ];
    })
  ];
}
