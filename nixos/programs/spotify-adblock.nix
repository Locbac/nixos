{ config, pkgs, inputs, ... }:
{
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball { 
      url = "https://github.com/nix-community/NUR/archive/master.tar.gz" ;
      sha256 = "1lrfpiybk6aii77zskfl5q2hci79nvx0x2a31rjlcqzpfmp0m663";
        }
      ) 
      {
      inherit pkgs;
    };
  };
  environment.systemPackages = with pkgs; [
  nur.repos.nltch.spotify-adblock    #for installing spotify-adblock
  ];
}
