#!/usr/bin/env bash

v=$(sudo ddcutil -d 1 getvcp 10 | sed -n "s/.*current value = *\([^']*\), max value =   100.*/\1/p")

if [ $v -gt 50 ]
then
  echo ""
else
  echo ""
fi