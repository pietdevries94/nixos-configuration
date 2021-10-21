#!/usr/bin/env bash

function chkwin {
    sudo virsh domstate --domain win10 | grep 'running' > /dev/null
}

if chkwin
then
  remmina -c ~/.local/share/remmina/vm_rdp_win10_192-168-122-161.remmina
else
  sudo virsh start win10
fi
