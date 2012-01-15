#!/bin/zsh

if [[ "$DESKTOP_SESSION" == (xmonad|wmii) ]]; then
	feh --bg-fill "/home/amadeus/Downloads/Mount_Snowdon,_Wales_by_Adam_Vellender.jpg"
fi

if [[ "$DESKTOP_SESSION" == (xmonad*|wmii) ]]; then
	xcompmgr -c &
fi
