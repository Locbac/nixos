{ config, pkgs, inputs, ... }:
{
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
  environment.systemPackages = with pkgs; [
  nur.repos.nltch.spotify-adblock    #for installing spotify-adblock
  ];
}
