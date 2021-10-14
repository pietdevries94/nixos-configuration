#!/usr/bin/env bash

function chkheadphones {
  bluetoothctl info CC:98:8B:56:FC:66 | grep 'Connected: yes' > /dev/null
}

if chkheadphones
then
  bluetoothctl disconnect CC:98:8B:56:FC:66 > /dev/null
else
  bluetoothctl connect CC:98:8B:56:FC:66 > /dev/null
fi
