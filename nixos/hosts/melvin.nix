{ config, lib, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "amdgpu" ];

  boot = {
    initrd.availableKernelModules = [
      "ahci"
      "ohci_pci"
      "ehci_pci"
      "pata_atiixp"
      "xhci_pci"
      "firewire_ohci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];

    initrd.kernelModules = [ ];
    kernelModules = [
      "kvm-amd"
      "amdgpu"
      "radeon"
    ];
    extraModulePackages = [ ];

    kernelParams = [
      "radeon.cik_support=0"
      "radeon.si_support=0"
      "amdgpu.cik_support=1"
      "amdgpu.si_support=1"
      "amdgpu.dc=1"
    ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };
  };
  
  hardware.enableRedistributableFirmware = true;

  networking = {
    useDHCP = false;
    interfaces.enp3s0.useDHCP = true;
  };
  
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/9dd3e046-4e6b-48a3-9592-5f8b9c4cdf28";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/6F00-D804";
      fsType = "vfat";
    };
  };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 8;

  system.stateVersion = "20.03";
}
