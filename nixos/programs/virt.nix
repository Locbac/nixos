{ inputs, outputs, lib, config, pkgs, ... }:
{
  programs.dconf.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.unstable.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };
  programs.virt-manager.enable = true;
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
  environment = {
    systemPackages = with pkgs; [ 
      dconf
      qemu 
      virt-manager
      virt-viewer
      spice.spice-gtk
      spice-protocol
      win-virt
    ];
  };
# FIXME: Change user 'amon' to your user.
  users.users.amon.extraGroups = [ "libvirtd" ];
}
