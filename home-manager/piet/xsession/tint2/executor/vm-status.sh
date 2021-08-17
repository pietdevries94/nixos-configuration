#!/usr/bin/env bash

function chkwin {
    sudo virsh domstate --domain win10 | grep 'running' > /dev/null
}

if chkwin
then
  echo ""
else
  echo ""
fi
