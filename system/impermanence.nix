{
  lib,
  config,
  inputs,
  ...
}: {
  options.impermanence.enable = lib.mkEnableOption "impermanence";

  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  config = lib.mkIf config.impermanence.enable {
    fileSystems."/persist".neededForBoot = true;

    boot.initrd.postResumeCommands = lib.mkAfter ''
      zfs rollback -r zroot/root@blank
    '';

    environment.persistence."/persist" = {
      hideMounts = true;

      directories = [
        "/etc/NetworkManager/system-connections"

        "/mnt/samba"
        "/mnt/syncthing"

        "/srv/minecraft"

        "/var/db/sudo/lectured"
        "/var/lib/bluetooth"
        "/var/lib/containers"
        "/var/lib/docker"
        "/var/lib/github-runner"
        "/var/lib/mysql"
        "/var/lib/nixos"
        "/var/lib/samba"
        "/var/lib/tailscale"
        "/var/lib/teamviewer"

        "/var/log"

        "/var/spool/slurmctld"
        "/var/spool/slurmd"

        "/var/www"
      ];

      users.c4patino = {
        directories = [
          ".android"
          "Android"

          ".cache/direnv"
          ".cache/spotify"
          ".cache/spotify-player"
          ".cache/vivaldi"

          ".conan2"

          ".config/autostart"
          ".config/gh"
          ".config/Google"
          ".config/JetBrains"
          ".config/libreoffice"
          ".config/obs-studio"
          ".config/obsidian"
          ".config/pnpm"
          ".config/Postman"
          ".config/pypoetry"
          ".config/Slack"
          ".config/spotify"
          ".config/spotify-player"
          ".config/teamviewer"
          ".config/variety"
          ".config/VirtualBox"
          ".config/vivaldi"
          ".config/WebCord"

          "Documents"
          "dotfiles"
          ".gnupg"
          ".java"

          ".local/share/applications"
          ".local/share/containers"
          ".local/share/direnv"
          ".local/share/Google"
          ".local/share/JetBrains"
          ".local/share/nvim"
          ".local/share/pnpm"
          ".local/share/PrismLauncher"
          ".local/share/racket"
          ".local/share/Steam"
          ".local/share/zoxide"
          ".local/share/zsh"

          "Obsidian"
          "Pictures"
          "Programming"
          ".pm2"
          ".steam"
          ".vim"
          "VirtualBox VMs"
        ];

        files = [
          ".ssh/known_hosts"
        ];
      };
    };
  };
}
