{ inputs, outputs, lib, config, pkgs, ... }:
{
  modules = [
  inputs.hardware.nixosModules.dell-precision-5530
  ];
}
