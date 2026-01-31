#! /bin/bash
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
eval "$(dbus-launch --sh-syntax)" &

# fast launch on GTK/Qt apps
fc-cache -f &
gtk-update-icon-cache -q &

# keep clipboard content
wl-clip-persist --clipboard regular --reconnect-tries 0 &

# clipboard content manager
wl-paste --type text --watch cliphist store &

# polkit (auth)
if ! pgrep -x "xfce-polkit" >/dev/null; then
  /usr/lib/xfce-polkit/xfce-polkit &
fi

# Noctalia Shell
qs -c noctalia-shell &
