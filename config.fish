starship init fish | source
set fish_greeting

if status is-interactive
end

## Set Path ##
fish_add_path -p "$HOME"/.local/bin

## Aliases ##
alias weather "curl wttr.in"
alias btw "neofetch"
alias ls "ls -ah --color=auto"
alias ip "ip -c"
alias b "btop"
alias n "nvim"
alias reboot "sudo reboot now"
alias shutdown "sudo shutdown now"
alias vmstart "virsh start win11"
alias vmstop "virsh destroy win11"

alias clone "git clone"
alias add "git add"
alias commit "git commit"
alias push "git push"
alias pull "git pull"
alias gstat "git status"

alias sysup "echo -e '\n=== REPO UPDATES ===\n' && yay -Syu && echo -e '\n=== UPDATING OMF ===\n' && omf update"

## Environment Variables ##
set -gx XDG_CONFIG_HOME "$HOME"/.config
set -gx XDG_CACHE_HOME "$HOME"/.cache
set -gx XDG_DATA_HOME "$HOME"/.local/share
set -gx XDG_STATE_HOME "$HOME"/.local/state
set -gx CUDA_CACHE_PATH "$XDG_CACHE_HOME"/nv
set -gx _JAVA_OPTIONS -Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
set -gx GNUPGHOME "$XDG_DATA_HOME"/gnupg
set -gx CARGO_HOME "$XDG_DATA_HOME"/cargo
set -gx NUGET_PACKAGES "$XDG_CACHE_HOME"/NuGetPackages
set -gx XAUTHORITY "$XDG_RUNTIME_DIR"/Xauthority
set -gx CARGO_HOME "$XDG_DATA_HOME"/cargo
set -gx NUGET_PACKAGES "$XDG_CACHE_HOME"/NuGetPackages
set -gx WGETRC "$XDG_CONFIG_HOME"/wgetrc
set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1
set -gx EDITOR nvim
set -gx RUSTUP_HOME "$XDG_DATA_HOME"/rustup
set -gx TERMINFO "$XDG_DATA_HOME"/terminfo
set -gx TERMINFO_DIRS "$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
set -gx GTK_RC_FILES "$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
set -gx GTK2_RC_FILES "$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
set -gx KDEHOME "$XDG_CONFIG_HOME"/kde
set -gx QT_QPA_PLATFORM wayland
set -gx SDL_VIDEODRIVER wayland
set -gx CLUTTER_BACKEND wayland
set -gx GBM_BACKEND nvidia-drm
set -gx __GLX_VENDOR_LIBRARY_NAME nvidia
set -gx QT_QPA_PLATFORMTHEME qt5ct
set -gx MOZ_ENABLE_WAYLAND 1
set -x MANPAGER "nvim +Man!"
