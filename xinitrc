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
    xsetroot -name "| getusage |  $(uptime | awk '{print $3" "$4}' | sed 's/,//') | getwifistatus | getaudiosource |  $(date +"%H:%M %a %d %B %Y") |"
    sleep 1s
done &

# Set Keymap
setxkbmap -layout gb &

# Load Xresources
xrdb ~/.config/X11/xresources

# Start sxhkd
sxhkd &

# relaunch DWM if the binary changes, otherwise bail
csum=""
new_csum=$(sha1sum $(which dwm))
while true
do
    if [ "$csum" != "$new_csum" ]
    then
        csum=$new_csum
        exec dwm
    else
        exit 0
    fi
    new_csum=$(sha1sum $(which dwm))
    sleep 0.5
done
