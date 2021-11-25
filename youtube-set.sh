#!/bin/bash

#API Settings for plugin.video.youtube
#Author: Alex Kotov aka alex_q_2000 (C) 2021
#License: GPLv3

fname="/home/$USER/.kodi/userdata/addon_data/plugin.video.youtube/settings.xml"

row=$(zenity --forms --title="YouTube API Settings" --text="Input data" \
   --add-entry="API_Key" \
   --add-entry="Client_ID" \
   --add-entry="Client_Secret")

[[ "$?" != "0" ]] && exit 1

akey=$(echo $row | cut -f1 -d "|"); cid=$(echo $row | cut -f2 -d "|")
csec=$(echo $row | cut -f3 -d "|")

sed -i 's/<setting id="youtube.api.key".*/<setting id="youtube.api.key">'$akey'<\/setting>/g' "$fname"
sed -i 's/<setting id="youtube.api.id".*/<setting id="youtube.api.id">'$cid'<\/setting>/g' "$fname"
sed -i 's/<setting id="youtube.api.secret".*/<setting id="youtube.api.secret">'$csec'<\/setting>/g' "$fname"

exit;
