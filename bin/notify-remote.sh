#!/bin/sh

delay="12000"

read line
summary="$line"
read line
msg="$line"
read line

if [ "$line" = "" ] && [ "$summary" != "" ]; then
    [ -x "$(which notify-send)" ] && notify-send -i stock_about -t "$delay" -- "$summary" "$msg"
fi
