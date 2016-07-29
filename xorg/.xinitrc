setxkbmap -option compose:ralt
setxkbmap -option terminate:ctrl_alt_bksp
setxkbmap -layout gb
xrdb -m .Xresources
xscreensaver -no-splash&
dropbox start&
xbindkeys
exec i3
