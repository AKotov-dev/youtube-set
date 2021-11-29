#!/bin/bash

#API Settings for plugin.video.youtube
#Author: Alex Kotov aka alex_q_2000 (C) 2021
#License: GPLv3

#Language select
case $LANG in
     ru_RU.UTF-8)
          msg=('plugin.video.youtube не установлен!' \
          'Настройка YouTube API' \
          'Настройки API plugin.video.youtube сохранены в файл:' \
          'Пустые значения недопустимы!')
          ;;
     *)
          msg=('The plugin.video.youtube not installed!' \
          'YouTube API Setting' \
          'The API settings of the plugin.video.youtube saved in the file:' \
          'Empty values are not allowed!')
          ;;
esac

#Settings file
fname="/home/$USER/.kodi/userdata/addon_data/plugin.video.youtube/settings.xml"

#The settings file exists?
if [[ ! -f "$fname" ]]; then
    zenity --warning --no-wrap --text "${msg[0]}"
    exit 1;
fi;

#Getting a string of parameters
row=($(zenity --forms --separator=" " --title="KODI" --text="${msg[1]}" \
   --add-entry="API_Key" \
   --add-entry="Client_ID" \
   --add-entry="Client_Secret"))

#Cancel or Close?
[[ "$?" != "0" ]] && exit 1

#If valid, insert the parameters into the settings file
if [[ ${row[0]} && ${row[1]} && ${row[2]} ]]; then
    sed -i 's/<setting id="youtube.api.key".*/<setting id="youtube.api.key">'${row[0]}'<\/setting>/g' "$fname"
    sed -i 's/<setting id="youtube.api.id".*/<setting id="youtube.api.id">'${row[1]}'<\/setting>/g' "$fname"
    sed -i 's/<setting id="youtube.api.secret".*/<setting id="youtube.api.secret">'${row[2]}'<\/setting>/g' "$fname"

    zenity --info --no-wrap --text "${msg[2]}\n$fname"
	else
    zenity --warning --no-wrap --text "${msg[3]}"
fi;

exit 0;
