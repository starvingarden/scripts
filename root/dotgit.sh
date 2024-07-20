#!/bin/bash

# this script manages dotfiles with git

# run by appending either "push" to push dotfile changes to github, or "pull" to pull dotfile changes from github

action=$1





# configure the git repo
########################

# create the ~/.dotgit directory if it doesn't exist
mkdir ~/.dotgit

# clear the ~/.dotgit directory
rm -rf ~/.dotgit/*

# initialize the git repo
git init ~/.dotgit

# set the remote repo
git --git-dir="$HOME/.dotgit/.git" --work-tree="$HOME/.dotgit" remote add origin https://github.com/starvingarden/dotfiles





# push dotfile changes to github
################################

if [ "$action" == push ]
then

    # copy dotfiles to the ~/.dotgit directory
    ##########################################

    # alacritty
    cp -r ~/.config/alacritty ~/.dotgit

    # bash
    mkdir ~/.dotgit/bash
    cp ~/.bash_profile ~/.dotgit/bash
    cp ~/.bashrc ~/.dotgit/bash

    # cava
    cp -r ~/.config/cava ~/.dotgit
 
    # dark-theme
    cp -r ~/.config/dark-theme ~/.dotgit

    # default-apps
    mkdir ~/.dotgit/default-apps
    cp ~/.config/mimeapps.list ~/.dotgit/default-apps

    # fastfetch
    cp -r ~/.config/fastfetch ~/.dotgit

    # fuzzel
    cp -r ~/.config/fuzzel ~/.dotgit

    # gammastep
    cp -r ~/.config/gammastep ~/.dotgit

    # info
    mkdir ~/.dotgit/info
    cp ~/.infokey ~/.dotgit/info

    # mako
    cp -r ~/.config/mako ~/.dotgit

    # nvim
    cp -r ~/.config/nvim ~/.dotgit

    # sway
    cp -r ~/.config/sway ~/.dotgit

    # swaylock
    cp -r ~/.config/swaylock ~/.dotgit

    # tealdeer
    cp -r ~/.config/tealdeer ~/.dotgit

    # wallpapers
    cp -r ~/.config/wallpapers ~/.dotgit

    # waybar
    cp -r ~/.config/waybar ~/.dotgit

    # zathura
    cp -r ~/.config/zathura ~/.dotgit



    # set permissions for dotfiles
    ##############################

    chmod -R 755 ~/.dotgit



    # push dotfiles to online git repo
    ##################################

    git --git-dir="$HOME/.dotgit/.git" --work-tree="$HOME/.dotgit" add .
    git --git-dir="$HOME/.dotgit/.git" --work-tree="$HOME/.dotgit" commit -m "update dotfiles"
    git --git-dir="$HOME/.dotgit/.git" --work-tree="$HOME/.dotgit" push -f origin main

fi





# pull dotfile changes from github
##################################

if [ "$action" == pull ]
then

    # pull dotfiles from online git repo
    ####################################

    git --git-dir="$HOME/.dotgit/.git" --work-tree="$HOME/.dotgit" pull origin main



    # set permissions for dotfiles
    ##############################

    chmod -R 755 ~/.dotgit



    # copy dotfiles from ~/.dotgit directory to appropriate locations
    #################################################################

    # alacritty
    cp -r ~/.dotgit/alacritty ~/.config

    # bash
    cp -r ~/.dotgit/bash/. ~

    # cava
    cp -r ~/.dotgit/cava ~/.config
 
    # dark-theme
    cp -r ~/.dotgit/dark-theme ~/.config

    # default-apps
    cp -r ~/.dotgit/default-apps/. ~/.config

    # fastfetch
    cp -r ~/.dotgit/fastfetch ~/.config

    # fuzzel
    cp -r ~/.dotgit/fuzzel ~/.config

    # gammastep
    cp -r ~/.dotgit/gammastep ~/.config

    # info
    cp -r ~/.dotgit/info/. ~

    # mako
    cp -r ~/.dotgit/mako ~/.config

    # nvim
    cp -r ~/.dotgit/nvim ~/.config

    # sway
    cp -r ~/.dotgit/sway ~/.config

    # swaylock
    cp -r ~/.dotgit/swaylock ~/.config

    # tealdeer
    cp -r ~/.dotgit/tealdeer ~/.config

    # wallpapers
    cp -r ~/.dotgit/wallpapers ~/.config

    # waybar
    cp -r ~/.dotgit/waybar ~/.config

    # zathura
    cp -r ~/.dotgit/zathura ~/.config

fi
