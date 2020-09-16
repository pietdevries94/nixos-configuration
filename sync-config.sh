#!/usr/bin/env nix-shell
#!nix-shell -i bash -p rsync

DIRECTORY="$(cd `dirname $0` && pwd)/"
rsync --delete --chown=root:root --filter=":- .gitignore" -avh $DIRECTORY /etc/nixos/