#!/bin/bash

# this script manages scripts with git

# run by appending either "push" to push script changes to github, or "pull" to pull script changes from github

action=$1





# configure the git repo
########################

# create the /.scriptgit directory if it doesn't exist
mkdir /.scriptgit

# clear the /.scriptgit directory
rm -rf /.scriptgit/*

# initialize the git repo
git init /.scriptgit

# set the remote repo
git --git-dir=/.scriptgit/.git --work-tree=/.scriptgit remote add origin https://github.com/starvingarden/scripts





# push script changes to github
###############################

if [ "$action" == push ]
then

    # copy scripts to the /.scriptgit directory
    ###########################################

    cp -r /scripts/* /.scriptgit



    # push scripts to online git repo
    #################################

    git --git-dir=/.scriptgit/.git --work-tree=/.scriptgit add .
    git --git-dir=/.scriptgit/.git --work-tree=/.scriptgit commit -m "update scripts"
    git --git-dir=/.scriptgit/.git --work-tree=/.scriptgit push -f origin main

fi





# pull script changes from github
#################################

if [ "$action" == pull ]
then

    # pull scripts from online git repo
    ###################################

    git --git-dir=/.scriptgit/.git --work-tree=/.scriptgit pull origin main



    # copy scripts from ~/.bingit directory to appropriate locations and set permissions
    ####################################################################################

    cp -r /.scriptgit/* /scripts
    chown -R root:root /scripts
    chmod -R 755 /scripts/all
    chmod 755 /scripts/root
    chmod 754 /scripts/root/*

fi
