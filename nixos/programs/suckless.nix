{ inputs, outputs, lib, config, pkgs, ... }:
{
  ## DWM
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.desktopManager.session = [
  	{
	  manage = "desktop";
	  name = "dwm";
	  start = ''
	  exec dwm
	  '';
    }
  ];
  ## OVERLAYS
  nixpkgs.overlays = [
  	(final: prev:{
  dwm = prev.dwm.overrideAttrs (old: {
  	src = /home/amon/proj/home/clones/dwm-flexipatch; 
      buildInputs = old.buildInputs ++ [ final.imlib2 final.xorg.libXrender final.xorg.libXext final.fontconfig ]; 
      });
  	})
  	(final: prev:{
  dmenu = prev.dmenu.overrideAttrs (old: { 
  	src = /home/amon/proj/home/clones/dmenu-flexipatch; 
      buildInputs = old.buildInputs ++ [ final.xorg.libXrender final.fontconfig ]; 
      });
  	})
  	(final: prev:{
  dwmblocks = prev.dwmblocks.overrideAttrs (old: { 
  	src = /home/amon/proj/home/clones/dwmblocks; 
      });
  	})
  	(final: prev:{
  slock = prev.slock.overrideAttrs (old: { 
  	src = /home/amon/proj/home/clones/slock-flexipatch; 
      buildInputs = old.buildInputs ++ [ final.xorg.libXext final.imlib2 final.xorg.libXrender final.fontconfig final.xorg.libXinerama ]; 
      });
  	})
  	(final: prev:{
  st = prev.st.overrideAttrs (old: { 
  	src = /home/amon/proj/home/clones/st-flexipatch; 
      buildInputs = old.buildInputs ++ [ final.xorg.libXrender ]; 
      });
  	})
  ];
}
