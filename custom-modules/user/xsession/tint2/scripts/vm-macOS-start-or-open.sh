#!/usr/bin/env bash

function chkwin {
    sudo virsh domstate --domain macOS | grep 'running' > /dev/null
}

if chkwin
then
  remmina -c ~/.local/share/remmina/vm_spice_macos_localhost-5900.remmina
else
  sudo virsh start macOS
fi
