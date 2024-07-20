#!/bin/bash

# variables
###########

snapshotType=pre-update
maxsnapshotCount=10
currentTime=$(date)





# clean up old snapshots
########################

# delete old root snapshots
while true
do
# get number of existing root snapshots
rootsnapshotCount=$(btrfs subvolume list -o /.snapshots | grep 'root' | grep -c "$snapshotType")
	if [ "$rootsnapshotCount" -ge "$maxsnapshotCount" ]
	then
		# get name of oldest root snapshot
		oldestrootSnapshot=$(btrfs subvolume list -o /.snapshots | grep 'root' | grep "$snapshotType" | head -n 1 | grep -Eo 'snapshots[[:print:]]*$')

		# delete oldest root snapshot
		btrfs subvolume delete "/.$oldestrootSnapshot"
	else
		break
	fi
done


# delete old home snapshots
while true
do
# get number of existing home snapshots
homesnapshotCount=$(btrfs subvolume list -o /.snapshots | grep 'home' | grep -c "$snapshotType")
	if [ "$homesnapshotCount" -ge "$maxsnapshotCount" ]
	then
		# get name of oldest home snapshot
		oldesthomeSnapshot=$(btrfs subvolume list -o /.snapshots | grep 'home' | grep "$snapshotType" | head -n 1 | grep -Eo 'snapshots[[:print:]]*$')

		# delete oldest home snapshot
		btrfs subvolume delete "/.$oldesthomeSnapshot"
	else
		break
	fi
done





# create read-only btrfs snapshots
##################################

btrfs subvolume snapshot -r / /.snapshots/root/"$snapshotType"/"$currentTime"
btrfs subvolume snapshot -r /home /.snapshots/home/"$snapshotType"/"$currentTime"
