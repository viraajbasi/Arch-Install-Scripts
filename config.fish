if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
set fish_greeting

# Aliases
function weather
	curl wttr.in
end

function g
	git
end

function vim
	nvim
end

function sysup
	yay -Syu
end

function install
	yay -S
end

function remove
	yay -Rcns
end

function search
	yay -Ss
end

function ytdl
	youtube-dl
end
