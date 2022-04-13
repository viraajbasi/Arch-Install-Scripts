starship init fish | source
set fish_greeting

if status is-interactive
	pfetch
end

## Environment Variables ##
set -gx XDG_CONFIG_HOME "$HOME"/.config
set -gx XDG_CACHE_HOME "$HOME"/.cache
set -gx XDG_DATA_HOME "$HOME"/.local/share
set -gx XDG_STATE_HOME "$HOME"/.local/state
set -gx ZDOTDIR "$HOME"/.config/zsh
set -gx HISTFILE "$ZDOTDIR"/history
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

## Set Path ##
fish_add_path -p "$HOME"/.local/bin

## Aliases ##
alias weather "curl wttr.in"
alias starwars "telnet towel.blinkenlights.nl"
alias btw "neofetch"
alias ls "ls -ah --color=auto"
alias ip "ip -c"
alias b "btop"
alias n "nvim"
alias c "code"
alias reboot "sudo reboot now"
alias shutdown "sudo shutdown now"
alias vmstart "virsh start win11"
alias vmstop "virsh destroy win11"
alias rmdir "rm -rf"

alias clone "git clone"
alias add "git add"
alias commit "git commit"
alias push "git push"
alias fetch "git fetch"
alias pull "git pull"
alias gstat "git status"

alias sysup "echo -e '=== REPO UPDATES ===\n' && yay -Syu && echo -e '\n=== UPDATING OMF ===\n' && omf update"
alias install "yay -S"
alias remove "yay -Rcns"
alias lsorphans "yay -Qtdq"
alias info "yay -Qi"
alias lsaur "yay -Qm"
alias lsall "yay -Q"
alias lsinst "yay -Qe"

alias solo "$HOME/Games/GTASoloSession.sh"
alias vmgroups "$HOME/src/groups.sh"
alias vmusb "$HOME/src/usb.sh"
