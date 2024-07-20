#!/bin/bash

airplaneCheck=$(rfkill --noheadings --output SOFT list wlan)

if [ "$airplaneCheck" == blocked ]
then
    echo -e "󰀝"
fi
