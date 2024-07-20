#!/bin/bash
# this script is used to update certain things

# update man pages
mandb

# update tldr pages
tldr --update

# update mlocate database
updatedb

# run reflector
systemctl start reflector.service
