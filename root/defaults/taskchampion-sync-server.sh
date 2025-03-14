#!/usr/bin/with-contenv bash
# shellcheck shell=bash
#
# beets music tagger - post-processing script
#
# Author: Rich Manton (overbyrn)
# Date: 29-04-13
#
# $1 - Fullpath of directory to be processed.  eg./mnt/user/downloads/some.artist_some.album

# $7 - Status of post processing. 0 = OK, 1 = failed verification, 2 = failed unpack, 3 = 1+2
if [ -n "$7" ] && [ "$7" -gt 0 ]; then
    echo "post-processing failed, bypassing script"
    exit 1
fi

# process files
echo "--------------------------"
printf %b "$(date)\n"
echo "Starting taskchampion-sync-server.sh for $(basename "$1")"

