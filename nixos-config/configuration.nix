{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Packages
  environment.systemPackages = with pkgs; [
    vim neovim
    wget curl git
    zsh
    tree fzf
    ncdu
    htop
    unzip
    stow

    zig
    clang
    cargo rustc
    python310Full

    lshw
    acpi
    brightnessctl

    hyprsunset hyprlock
    rose-pine-hyprcursor
    bemenu
    alacritty
    brave
    prismlauncher
    blender
    krita
  ];

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "lenovo-nixos";
  networking.networkmanager.enable = true;
  services.openssh.enable = true;

  # Internationalisation
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "uk";

  # User
  users.users.alexydens = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
    ];
  };

  # Nvidia
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.prime.intelBusId = "PCI:0:2:0";
  hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0";

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Audio
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.pulse.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Zsh
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.autosuggestions.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.histSize = 10000;
  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.ohMyZsh.plugins = [ "git" "fzf" ];
  programs.zsh.ohMyZsh.theme = "eastwood";
  programs.zsh.shellAliases = {
    rebuild-config = "sudo nixos-rebuild switch --flake ~/nixos-config";
    collect-garbage = "sudo nix-collect-garbage --delete-old";
    status = "python ~/status.py tk";
  };

  # Hyprland
  security.polkit.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  # Steam
  programs.steam.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # DON'T EDIT
  system.stateVersion = "25.05";
}
