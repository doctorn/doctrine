{ config, lib, pkgs, ... }:

{
  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "nvme"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc" 
    ];

    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

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

  networking = {
    useDHCP = false;
    interfaces.wlp58s0.useDHCP = true;
  };
  
  fileSystems = {
    "/" = { device = "/dev/disk/by-uuid/5a5c1cc3-28a8-40c7-960c-5f797657af17";
      fsType = "ext4";
    };
    "/boot" = { device = "/dev/disk/by-uuid/D6FD-3763";
      fsType = "vfat";
    };
  };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/0e973be5-5cd9-4ce1-99ae-6df2fb3b335a"; }
    ];

  nix.maxJobs = lib.mkDefault 4;
  
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  hardware = {
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
  };

  system.stateVersion = "20.09";
}
