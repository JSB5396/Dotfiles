#!/bin/bash

# Color palette variables
background=1c1e26
foreground=e0e0e0

regular_0=16161c
regular_1=e95678
regular_2=29d398
regular_3=fab795
regular_4=26bbd9
regular_5=ee64ac
regular_6=59e1e3
regular_7=d5d8da

bright_0=5b5858
bright_1=ec6a88
bright_2=3fdaa4
bright_3=fbc3a7
bright_4=3fc4de
bright_5=f075b5
bright_6=6be4e6
bright_7=d5d8da

# Path to the config files
profile_dir=$(sed -n 's/^Path=\(.*\.default-default\)$/\1/p' "$HOME/.config/mozilla/firefox/profiles.ini")
firefox="$HOME/.config/mozilla/firefox/$profile_dir/chrome/theme.css"
firefox_dot=$HOME/.config/mozilla/firefox/chrome/theme.css
foot=$HOME/.config/foot/foot.ini
fuzzel=$HOME/.config/fuzzel/fuzzel.ini
mako=$HOME/.config/mako/config
sway=$HOME/.config/sway/config
swaylock=$HOME/.config/swaylock/config
waybar=$HOME/.config/waybar/style.css
wlogout=$HOME/.config/wlogout/style.css

# Apply color palette changes to config files
sed -i \
  -e "s/--base:.*/--base:#${background};/g" \
  -e "s/--text:.*/--text:#${foreground};/g" \
  -e "s/--subtle:.*/--subtle:#${regular_1};/g" \
  -e "s/--overlay:.*/--overlay:#${regular_0};/g" \
  "$firefox" "$firefox_dot"

sed -i \
  -e "s/background=.*/background=${background}/g" \
  -e "s/foreground=.*/foreground=${foreground}/g" \
  -e "s/regular0=.*/regular0=${regular_0}  # black/g" \
  -e "s/regular1=.*/regular1=${regular_1}  # red/g" \
  -e "s/regular2=.*/regular2=${regular_2}  # green/g" \
  -e "s/regular3=.*/regular3=${regular_3}  # yellow/g" \
  -e "s/regular4=.*/regular4=${regular_4}  # blue/g" \
  -e "s/regular5=.*/regular5=${regular_5}  # magenta/g" \
  -e "s/regular6=.*/regular6=${regular_6}  # cyan/g" \
  -e "s/regular7=.*/regular7=${regular_7}  # white/g" \
  -e "s/bright0=.*/bright0=${bright_0}   # bright black/g" \
  -e "s/bright1=.*/bright1=${bright_1}   # bright red/g" \
  -e "s/bright2=.*/bright2=${bright_2}   # bright green/g" \
  -e "s/bright3=.*/bright3=${bright_3}   # bright yellow/g" \
  -e "s/bright4=.*/bright4=${bright_4}   # bright blue/g" \
  -e "s/bright5=.*/bright5=${bright_5}   # bright magenta/g" \
  -e "s/bright6=.*/bright6=${bright_6}   # bright cyan/g" \
  -e "s/bright7=.*/bright7=${bright_7}   # bright white/g" \
  "$foot"

sed -i \
  -e "s/background=.*/background=${background}ff/g" \
  -e "s/text=.*/text=${foreground}ff/g" \
  -e "s/prompt=.*/prompt=${regular_7}ff/g" \
  -e "s/input=.*/input=${foreground}ff/g" \
  -e "s/match=.*/match=${regular_4}ff/g" \
  -e "s/selection=.*/selection=${regular_1}ff/g" \
  -e "s/selection-text=.*/selection-text=${regular_0}ff/g" \
  -e "s/selection-match=.*/selection-match=${regular_7}ff/g" \
  -e "s/border=.*/border=${regular_0}ff/g" \
  "$fuzzel"

sed -i \
  -e "s/background-color=.*/background-color=#${background}/g" \
  -e "s/text-color=.*/text-color=#${foreground}/g" \
  -e "6 s/border-color=.*/border-color=#${regular_0}/g" \
  -e "10 s/border-color=.*/border-color=#${regular_1}/g" \
  "$mako"

sed -i \
  -e "34 s/client.focused.*/client.focused #${regular_0} #${regular_0} #${regular_0} #${regular_0}/g" \
  -e "35 s/client.unfocused.*/client.unfocused #${background} #${background} #${background} #${background}/g" \
  -e "36 s/client.focused_inactive.*/client.focused_inactive #${background} #${background} #${background} #${background}/g" \
  "$sway"
  swaymsg reload

sed -i \
  -e "s/bs-hl-color=.*/bs-hl-color=${bright_0}/g" \
  -e "s/caps-lock-bs-hl-color=.*/caps-lock-bs-hl-color=${bright_0}/g" \
  -e "s/caps-lock-key-hl-color=.*/caps-lock-key-hl-color=${background}/g" \
  -e "s/inside-color=.*/inside-color=${background}/g" \
  -e "s/inside-clear-color=.*/inside-clear-color=${background}/g" \
  -e "s/inside-caps-lock-color=.*/inside-caps-lock-color=${background}/g" \
  -e "s/inside-ver-color=.*/inside-ver-color=${background}/g" \
  -e "s/inside-wrong-color=.*/inside-wrong-color=${background}/g" \
  -e "s/key-hl-color=.*/key-hl-color=${background}/g" \
  -e "s/line-color=.*/line-color=${regular_6}/g" \
  -e "s/line-clear-color=.*/line-clear-color=${regular_6}/g" \
  -e "s/line-caps-lock-color=.*/line-caps-lock-color=${regular_6}/g" \
  -e "s/line-ver-color=.*/line-ver-color=${regular_6}/g" \
  -e "s/line-wrong-color=.*/line-wrong-color=${regular_6}/g" \
  -e "s/ring-color=.*/ring-color=${regular_6}/g" \
  -e "s/ring-clear-color=.*/ring-clear-color=${regular_6}/g" \
  -e "s/ring-caps-lock-color=.*/ring-caps-lock-color=${regular_6}/g" \
  -e "s/ring-ver-color=.*/ring-ver-color=${regular_6}/g" \
  -e "s/ring-wrong-color=.*/ring-wrong-color=${regular_6}/g" \
  -e "s/separator-color=.*/separator-color=${regular_6}/g" \
  -e "s/text-color=.*/text-color=${regular_4}/g" \
  -e "s/text-clear-color=.*/text-clear-color=${regular_4}/g" \
  -e "s/text-caps-lock-color=.*/text-caps-lock-color=${regular_3}/g" \
  -e "s/text-ver-color=.*/text-ver-color=${regular_2}/g" \
  -e "s/text-wrong-color=.*/text-wrong-color=${regular_1}/g" \
  "$swaylock"

sed -i \
  -e "s/@define-color maincolor.*/@define-color maincolor #${regular_4};/g" \
  -e "s/@define-color accentcolor.*/@define-color accentcolor #${foreground};/g" \
  -e "s/@define-color bgmodule.*/@define-color bgmodule #${regular_0};/g" \
  -e "s/@define-color background.*/@define-color background #${background};/g" \
  "$waybar"

sed -i \
  -e "s/@define-color selectcolor.*/@define-color selectcolor #${regular_0};/g" \
  -e "s/@define-color bgcolor.*/@define-color bgcolor #${background};/g" \
  -e "s/@define-color shutdowncolor.*/@define-color shutdowncolor #${regular_1};/g" \
  -e "s/@define-color rebootcolor.*/@define-color rebootcolor #${regular_4};/g" \
  "$wlogout"
