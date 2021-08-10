#!/usr/bin/env bash

cd `dirname $0`
cd ../custom-modules

cat << EOF
{
  imports = [
EOF

find . -type f -name "default.nix" -printf '    %h\n' | grep -E "\ {4}\..+$" | sort

cat << EOF
  ];
}
EOF