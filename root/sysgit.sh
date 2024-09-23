#!/bin/bash

# this script manages system files with git

# run by appending either "push" to push system file changes to github, or "pull" to pull system file changes from github



# notable arch wiki pages
#########################

# System backup#Snapshots and /boot partition





action=$1





# check that script is running as root
######################################

currentUser=$(whoami)
if [ "$currentUser" == root ]
then
    :
else
    echo "this script must be run as root"
    exit
fi





# configure the git repo
########################

# create the /.sysgit directory if it doesn't exist
mkdir /.sysgit

# clear the /.sysgit directory
rm -rf /.sysgit/*

# initialize the git repo
git init /.sysgit

# set the remote repo
git --git-dir=/.sysgit/.git --work-tree=/.sysgit remote add origin https://github.com/starvingarden/system





# push system file changes to github
####################################

if [ "$action" == push ]
then

    # set permissions for system files
    ##################################


    
    # create appropritate directories to save system files
    ######################################################

    mkdir /.sysgit/systemd



    # copy system files to the /.sysgit directory
    #############################################

    cp /etc/systemd/system/snapshot* /.sysgit/systemd
    cp /etc/pacman.d/hooks/95-bootbackup.hook /.sysgit



    # push system files to online git repo
    ######################################

    git --git-dir=/.sysgit/.git --work-tree=/.sysgit add .
    git --git-dir=/.sysgit/.git --work-tree=/.sysgit commit -m "update system files"
    git --git-dir=/.sysgit/.git --work-tree=/.sysgit push -f origin main

fi





# pull system file changes from github
######################################

if [ "$action" == pull ]
then

    # pull system files from online git repo
    ########################################

    git --git-dir=/.sysgit/.git --work-tree=/.sysgit pull origin main



    # create appropritate directories for system files
    ##################################################

    mkdir /etc/pacman.d/hooks



    # copy system files from /.sysgit directory to appropriate locations
    ####################################################################

    cp /.sysgit/systemd/* /etc/systemd/system
    cp /.sysgit/95-bootbackup.hook /etc/pacman.d/hooks



    # set permissions for system files
    ##################################



    # enable appropriate systemd units
    ##################################

    systemctl daemon-reload
    systemctl enable snapshot-hourly.timer
    systemctl enable snapshot-daily.timer
    systemctl enable snapshot-weekly.timer

fi
