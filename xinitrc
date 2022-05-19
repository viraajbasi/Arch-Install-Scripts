# Set resolution and refresh rate
xrandr --output DP-0 --mode 2560x1440 --rate 144

#Polkit
polkit-dumb-agent &

# Wallpaper
hsetroot -fill ~/Pictures/Wallpapers/wallhaven-j3j5ym_2560x1440.png &

# Compositor
picom -b &

# Start dunst
dunst &

# Gnome keyring
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

# Bar config
while true; do
    xsetroot -name "| $(~/.local/bin/getusage) |  $(uptime | awk '{print $3}' | tr -d ',') | $(~/.local/bin/getwifistatus) | $(~/.local/bin/getaudiosource) |  $(date +"%H:%M %a %d %B %Y") |"
    sleep 1s
done &

# Set Keymap
setxkbmap -layout gb &

# Load Xresources
xrdb ~/.config/X11/xresources

# Start sxhkd
sxhkd &

# Start dwm
exec dwm
