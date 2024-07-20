#!/bin/bash

# check if vpn is running
vpnRunning=$(vpn.sh status)

# if vpn is running, check status
if [ -n "$vpnRunning" ]
then
    # check if vpn is connected
    vpnConnected=$(vpn.sh status | head -n 1 | grep -Eo ^Connected)

    # if vpn is not connected, display information
    if [ -z "$vpnConnected" ]
    then
        vpnStatus=$(vpn.sh status | head -n 1)
        echo "{\"text\":\"$vpnStatus\"}"
    fi
fi
