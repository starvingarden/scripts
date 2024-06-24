#!/bin/bash

# this script manages scripts with git

# run by appending either "push" to push script changes to github, or "pull" to pull script changes from github

action=$1





# configure the git repo
########################

# create the ~/.bingit directory if it doesn't exist
mkdir ~/.bingit

# clear the ~/.bingit directory
rm -rf ~/.bingit/*

# initialize the git repo
git init ~/.bingit

# set the remote repo
git --git-dir="$HOME/.bingit/.git" --work-tree="$HOME/.bingit" remote add origin https://github.com/starvingarden/scripts





# push script changes to github
###############################

if [ "$action" == push ]
then

    # copy scripts to the ~/.bingit directory
    #########################################

    cp -r ~/.bin/. ~/.bingit



    # push scripts to online git repo
    #################################

    git --git-dir="$HOME/.bingit/.git" --work-tree="$HOME/.bingit" add .
    git --git-dir="$HOME/.bingit/.git" --work-tree="$HOME/.bingit" commit -m "update scripts"
    git --git-dir="$HOME/.bingit/.git" --work-tree="$HOME/.bingit" push -f origin main

fi





# pull script changes from github
#################################

if [ "$action" == pull ]
then

    # pull scripts from online git repo
    ###################################

    git --git-dir="$HOME/.bingit/.git" --work-tree="$HOME/.bingit" pull origin main



    # copy scripts from ~/.bingit directory to appropriate locations and set permissions
    ####################################################################################

    cp -r ~/.bingit/. ~/.bin

fi
