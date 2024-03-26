# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "amon";
    homeDirectory = "/home/amon";
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };


  programs = {
    git = {
      enable = true;
      userName = "Locbac";
      userEmail = "martinhost003@gmail.com";
      };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      shellAliases = 
      {
        ## MOUNTS
        mnfs="sudo mount 192.168.0.101:/OldNerd /home/amon/windows-nfs";
        mmp="sudo mount --mkdir /dev/disk/by-uuid/2C06855C068527C2 '/run/media/amon/My Passport'";
        um="sudo umount '/run/media/amon/My Passport' /run/media/amon/Ventoy /run/media/amon/Gargantuan";
        ## LISTING
        ll="ls -alF";
        la="ls -A";
        l="ls -CF";
        ## NALA
        ni="sudo nala install";
        nr="sudo nala remove";
        na="sudo nala update";
        nu="sudo nala upgrade";
        nf="sudo nala fetch";
        nrr="sudo nala clean && sudo nala autoremove && sudo nala autopurge";
        ## PACMAN
        pci="sudo pacman -Sy";
        pcr="sudo pacman -R";
        ## MAKE
        smci="sudo make clean install";
        smi="sudo make install";
        ## GIT
        gpf="git add . && git commit -m 'push' && git push";
        gc="git clone";
        ## SHUTDOWN REBOOT
        ssn="sudo shutdown now";
        sr="sudo reboot";
        ## SCRIPTS
        tg="~/clones/grayscale-desktop/toggle-monitor-grayscale.sh";
        ## MISC
        sme="sudo chmod +x";
        rmallgitdir="rm -rf .git*";
        sn="EDITOR=nvim sudoedit";
        ## VMs
        looking-glass="looking-glass-client -m 97 -c DXGI";
        ## RUNNERS
        neo="neofetch";
        r="ranger";
        sur="sudo ranger";
        fr="flatpak run";
        ## NIXOS
        #enc="EDITOR=nvim sudoedit ~/.config/nixconf/nixos/configuration.nix";
        enc="nvim ~/.config/nixconf/";
        snor="sudo nixos-rebuild switch";
        snorf="sudo nixos-rebuild switch --flake ~/.config/nixconf/#nixos";
        hms="home-manager switch";
        hmsf="home-manager switch --flake ~/.config/nixconf/#amon@nixos";
        cnix="cd /etc/nixos/";
        cgnix="cd ~/.config/nixconf/";
        ng="sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
        nixclean="sudo nix-env --list-generations --profile /nix/var/nix/profiles/system && sudo nix-collect-garbage --delete-older-than 7d && sudo nixos-rebuild switch";
        nixcleanf="sudo nix-env --list-generations --profile /nix/var/nix/profiles/system && sudo nix-collect-garbage --delete-older-than 7d && sudo nixos-rebuild switch --flake ~/.config/nixconf/#nixos";
      };
      initExtraFirst = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      #POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
      '';
      initExtra = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [ 
        "git" 
        ];
        #theme = "powerlevel9k";
      };
    };
    ranger = {
      enable = true;
      mappings = {
          md = "console mkdir%space";
      };
    };
  };

  gtk = {
      enable = true;
      cursorTheme = {
        package = pkgs.apple-cursor;
        name = "macOS-BigSur";
        };
      iconTheme = {
        package = pkgs.whitesur-icon-theme;
        name = "WhiteSur-dark";
        };
      theme = {
        package = pkgs.whitesur-gtk-theme;
        name = "WhiteSur-Dark";
        };
    };

  qt = {
      enable = true;
      platformTheme = "gtk";
      style.name = "WhiteSur-Dark";
    };

  xresources.properties = {
      "Xft.dpi" = 110;
    };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
