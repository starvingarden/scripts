#!/bin/bash

# this script will run until the system is connected to the internet, then exit

until ping -c1 archlinux.org
do
    sleep 60
done
