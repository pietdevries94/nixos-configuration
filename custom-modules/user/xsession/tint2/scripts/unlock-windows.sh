#!/usr/bin/env bash

for node_id in $(bspc query -N -d focused); do                                                                                                                                                             ~
        bspc node $node_id -t floating
done