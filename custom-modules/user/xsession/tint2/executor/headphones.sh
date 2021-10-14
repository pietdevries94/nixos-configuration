#!/usr/bin/env bash

function chkheadphones {
    bluetoothctl info CC:98:8B:56:FC:66 | grep 'Connected: yes' > /dev/null
}

if chkheadphones
then
  echo ""
else
  echo ""
fi
