{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "lenovo-nixos";
  networking.networkmanager.enable = true;

  # Real time kit
  security.rtkit.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Audio
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.pulse.enable = true;

  # SSH
  services.openssh.enable = true;

  # Graphics
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.prime.intelBusId = "PCI:0:2:0";
  hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0";

  # Localisation
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_US.UTF-8";
  console.font = "Lat2-Terminus16";
  console.keyMap = "uk";
  users.users.alexydens = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
    ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    python310Full
    unzip
    zig
    clang
    cargo
    rustc
    vim
    neovim
    git
    stow
    wget
    fzf
    tree
    acpi
    lshw
    brightnessctl
    adw-gtk3
    libsForQt5.qt5ct
    qt6ct
    brave
    alacritty
    bemenu
    hyprsunset
    hyprlock
    rose-pine-hyprcursor
    prismlauncher
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

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Hyprland
  security.polkit.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  
  # Steam
  programs.steam.enable = true;

  # DO NOT EDIT
  system.stateVersion = "25.05";
}

