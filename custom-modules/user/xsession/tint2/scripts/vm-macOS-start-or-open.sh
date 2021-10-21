#!/usr/bin/env bash

function chkwin {
    sudo virsh domstate --domain macOS | grep 'running' > /dev/null
}

if chkwin
then
  echo "TODO"
else
  sudo virsh start macOS
fi
