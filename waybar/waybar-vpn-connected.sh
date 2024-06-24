#!/bin/bash

# check if vpn is connected
vpnConnected=$(vpn.sh status | head -n 1 | grep -Eo Connected)

# if vpn is connected, display information
if [ -n "$vpnConnected" ]
then
    vpnStatus=$(vpn.sh status | head -n 1)
    echo "{\"text\":\"$vpnStatus\"}"
fi
