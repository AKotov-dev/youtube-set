#!/bin/bash

#API Settings for plugin.video.youtube
#Author: Alex Kotov aka alex_q_2000 (C) 2021
#License: GPLv3

#Language select
case $LANG in
     ru_RU.UTF-8)
          str=('plugin.video.youtube не установлен!' 'Входные данные' \
          'Настройки API plugin.video.youtube сохранены в файл:' \
          'Пустые значения недопустимы!')
          ;;
     *)
          str=('The plugin.video.youtube not installed!' 'Input data' \
          'The API settings of the plugin.video.youtube saved in the file:' \
          'Empty values are not allowed!')
          ;;
esac

#Settings file
fname="/home/$USER/.kodi/userdata/addon_data/plugin.video.youtube/settings.xml"

#The settings file exists?
if [[ ! -f "$fname" ]]; then
    zenity --warning --no-wrap --text "${str[0]}"
    exit 1;
fi;

#Getting a string of parameters
row=$(zenity --forms --title="YouTube API Settings" --text="${str[1]}" \
   --add-entry="API_Key" \
   --add-entry="Client_ID" \
   --add-entry="Client_Secret")

#Cancel or Close?
[[ "$?" != "0" ]] && exit 1

#Parsing the output into parameters
akey=$(echo $row | cut -f1 -d "|"); cid=$(echo $row | cut -f2 -d "|"); csec=$(echo $row | cut -f3 -d "|")

#If valid, insert the parameters into the settings file
if [[ "$akey" && "$cid" && "$csec" ]]; then
    sed -i 's/<setting id="youtube.api.key".*/<setting id="youtube.api.key">'$akey'<\/setting>/g' "$fname"
    sed -i 's/<setting id="youtube.api.id".*/<setting id="youtube.api.id">'$cid'<\/setting>/g' "$fname"
    sed -i 's/<setting id="youtube.api.secret".*/<setting id="youtube.api.secret">'$csec'<\/setting>/g' "$fname"

    zenity --info --no-wrap --text "${str[2]}\n$fname"
	else
    zenity --warning --no-wrap --text "${str[3]}"
fi;

exit;
