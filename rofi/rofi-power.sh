#!/bin/bash

options="\n󰜉\n󰐊\n󰒲\n\n󰿅"

chosen=$(echo -e "$options" | rofi -dmenu -noinput -no-custom -theme-str '
    configuration { font: "jetbrains mono 28"; location: 4; }
    window { width: 92px; height: 388px; }
    listview { lines: 6; }
    inputbar { enabled: false; }
    prompt { enabled: false; }
    entry { enabled: false; }
    element {
        padding: 6px 0px 6px -12px;
        spacing: 0px;
        border-radius: 12px;
    }
    listview {
        padding: 4px;
        columns: 1;
        fixed-height: false;
    }
    ')

case "$chosen" in
    *"") /home/kasper/Документы/code/скрипты/safe_shutdown.sh ;;
    *"󰜉") systemctl reboot ;;
    *"󰐊") systemctl suspend ;;
    *"󰒲") systemctl hibernate ;;
    *"") hyprlock ;;
    *"󰿅") hyprctl dispatch exit ;;
esac