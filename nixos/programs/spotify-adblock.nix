{ config, pkgs, inputs, ... }:
{
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball { 
      url = "https://github.com/nix-community/NUR/archive/master.tar.gz" ;
      sha256 = "0nffnyc6x4xna0ckmck5s76ipjfwi5hnjv6n8fgs3lcszl02p68r";
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
