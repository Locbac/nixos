# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    dwm = prev.dwm.overrideAttrs (old: { 
      src = /home/amon/proj/home/clones/dwm-flexipatch; 
        buildInputs = old.buildInputs ++ [ final.imlib2 final.xorg.libXrender final.xorg.libXext final.fontconfig ]; 
      });
    dmenu = prev.dmenu.overrideAttrs (old: { 
      src = /home/amon/proj/home/clones/dmenu-flexipatch; 
        buildInputs = old.buildInputs ++ [ final.xorg.libXrender final.fontconfig ]; 
      });
    dwmblocks = prev.dwmblocks.overrideAttrs (old: { 
      src = /home/amon/proj/home/clones/dwmblocks; 
      });
    slock = prev.slock.overrideAttrs (old: { 
      src = /home/amon/proj/home/clones/slock-flexipatch; 
        buildInputs = old.buildInputs ++ [ final.xorg.libXext final.imlib2 final.xorg.libXrender final.fontconfig final.xorg.libXinerama ]; 
      });
    st = prev.st.overrideAttrs (old: { 
      src = /home/amon/proj/home/clones/st-flexipatch; 
        buildInputs = old.buildInputs ++ [ final.xorg.libXrender ]; 
      });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
