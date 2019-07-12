#!/usr/bin/env bash

PID=$(ps -a | grep spotify | awk 'NR==1{print $1}')
WID=$(wmctrl -l -p | grep $PID | awk '{print $1}')
xdotool windowminimize $WID

