if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
set fish_greeting

# Aliases
alias weather "curl wttr.in"
alias clone "git clone"
alias add "git add"
alias commit "git commit"
alias push "git push"
alias fetch "git fetch"
alias pull "git pull"
alias sysup "yay -Syu"
alias install "yay -S"
alias remove "yay -Rcns"
alias ytdl "youtube-dl"
alias btw "neofetch"
