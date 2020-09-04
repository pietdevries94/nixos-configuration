#!/usr/bin/env bash

function cvol {
    amixer get Master | grep '%' | head -n 1 | awk -F'[' '{print $2}' | awk -F'%' '{print $1}'
}

function chkmute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

v=$(cvol)

if chkmute
then
  echo ""
elif [ $v -gt 40 ]
then
  echo ""
elif [ $v -gt 20 ]
then
  echo ""
else
  echo ""
fi
