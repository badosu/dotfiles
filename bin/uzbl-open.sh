#!/bin/zsh

UZBL_TABBED_PID=$(ps aux | grep "[p]y.*uzbl-tabbed" | head -n 1 | awk '{print $2}')
if [ $UZBL_TABBED_PID ]; then
  echo "event NEW_TAB $1" >> /tmp/uzbl_fifo_${UZBL_TABBED_PID}-1
else
  uzbl-tabbed $1&
fi
