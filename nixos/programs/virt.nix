{ inputs, outputs, lib, config, pkgs, ... }:
{
  boot.kernelParams = [ "intel_iommu=on" "iommu=pt" ];

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
  environment = {
    systemPackages = with pkgs; [ 
      dconf
      qemu 
      virt-manager
      virt-viewer
      spice-gtk
      spice-protocol
      virtiofsd # required for virtio filesystem passthrough
      looking-glass-client
    ];
  };
# The following required for looking-glass.io
  systemd.tmpfiles.rules = [
# FIXME: Change user 'amon' to your user.
    "f /dev/shm/looking-glass 0660 amon kvm -"
  ];
# FIXME: Change user 'amon' to your user.
  users = {
    users.amon.extraGroups = [ "libvirtd" "virt-manager" ];
    groups.libvirtd.members = [ "root" "amon" ];
  };
}
