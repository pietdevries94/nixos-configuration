#!/usr/bin/env bash

function chkmute {
    amixer get Capture | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

if chkmute
then
  echo ""
else
  echo ""
fi
