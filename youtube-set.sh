#!/bin/bash

fname="/home/$USER/.kodi/userdata/addon_data/plugin.video.youtube/settings.xml"

row=$(zenity --forms --separator=" " --title="YouTube API Settings" --text="Input data" \
   --add-entry="API_Key" \
   --add-entry="Client_ID" \
   --add-entry="Client_Secret")

[[ "$?" != "0" ]] && exit 1

akey=$(echo $row | awk '{ print $1 }'); cid=$(echo $row | awk '{ print $2 }')
csec=$(echo $row | awk '{ print $3 }')

sed -i 's/<setting id="youtube.api.key">.*/<setting id="youtube.api.key">'$akey'<\/setting>/g' "$fname"
sed -i 's/<setting id="youtube.api.id">.*/<setting id="youtube.api.id">'$cid'<\/setting>/g' "$fname"
sed -i 's/<setting id="youtube.api.secret">.*/<setting id="youtube.api.secret">'$csec'<\/setting>/g' "$fname"

exit;
