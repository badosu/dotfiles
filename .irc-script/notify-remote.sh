#!/bin/sh
# note: notify-send is required, see libnotify-bin

# XXX do not notify if notification source has focus

delay="12000"

read line
summary="$line"
read line
msg="$line"
read line

if [ "$line" = "" ] && [ "$summary" != "" ]; then
    [ -x "$(which notify-send)" ] && notify-send --icon=stock_about -t "$delay" -- "$summary" "$msg"
fi
