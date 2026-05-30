{ config, pkgs, user,... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    htop
    foot                  # Wayland terminal emulator

    # gnome core apps
    nautilus              # file manager 
    gnome-text-editor     # text editor
    loupe                 # image viewer
    papers                # document viewer
    # decibels              # audio player
    # showtime              # video player
    gnome-disk-utility    # Udisks UI
    baobab                # disk usage
    gnome-font-viewer     # font viewer
    gnome-logs            # logs viewer
    gnome-software        # software store
    gnome-system-monitor  # system monitor


    # gnome extensions
    gnomeExtensions.gjs-osk
    gnomeExtensions.forge
    gnomeExtensions.blur-my-shell
    gnomeExtensions.vitals
  ];

  # GNOME Desktop Configuration
  dconf = {
    enable = true;

    settings = {

      # Auto enable default osk
      "org/gnome/desktop/ally/applications" = {
        screen-keyboard-enabled = true;
      };

      # Auto enable gnome extensions
      "org/gnome/shell" = {
        enabled-extensions = [
          "gjsosk@vishram1123.com"
          "forge@jmmaranan.com"
          "blur-my-shell@aunetx"
          "Vitals@CoreCoding.com"
        ];
      };

      # Display settings
      "org/gnome/mutter" = {
        experimental-features = [
          "scale-monitor-framebuffer" # Enables fractional scaling (125% 150% 175%)
          "variable-refresh-rate" # Enables Variable Refresh Rate (VRR) on compatible displays
          "xwayland-native-scaling" # Scales Xwayland applications to look crisp on HiDPI screens
          "autoclose-xwayland" # automatically terminates Xwayland if all relevant X11 clients are gone   
        ];
      };

    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

 
  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    # Firefox
    firefox = {
      enable = true;
      profiles.myprofile = {
        id = 0;
        name = "myprofile";
        isDefault = true;
        settings = {
          "browser.startup.homepage" = "https://google.com";
          "browser.search.defaultenginename" = "google";
          "browser.shell.checkDefaultBrowser" = false;
          "signon.rememberSignons" = false; # Disable built-in password manager
          "extensions.autoDisableScopes" = 0; # Keeps extenstions from being automatically disabled
        };
        # Install extensions (requires nixpkgs or NUR)
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          darkreader
        ];
      };
    };

  };
}
