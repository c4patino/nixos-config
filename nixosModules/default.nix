{ lib, pkgs, ... }: {
    imports = [
        ./virtualization
        ./audio.nix
        ./bootloader.nix
        ./hyprland.nix
        ./network-manager.nix
        ./nvidia.nix
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [ 
        home-manager 
        networkmanagerapplet
        gnupg

        nh
        nix-output-monitor
        nvd
    ];

    time.timeZone = "America/Chicago";
    time.hardwareClockInLocalTime = true;

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    networking.wireless.enable = true;

    services = {
        xserver = {
            enable = true;
            xkb = {
                layout = "us";
                variant = "";
            };
            displayManager.gdm.enable = true;
        };

        printing.enable = true;

        blueman.enable = true;
    };

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
    };

    security = {
        polkit.enable = true;
        rtkit.enable = true;
    };

    programs.zsh.enable = true;
    programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
            stdenv.cc.cc
            cudaPackages.cudatoolkit
        ];
    };

    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    system.stateVersion = "24.05";
}
