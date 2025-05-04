#!/usr/bin/env bash

LOG_FILE="/tmp/update.log"
touch $LOG_FILE
date >> "$LOG_FILE"
sudo dnf update -y >> "$LOG_FILE" 2>&1

# if today % 3 == 0
if [[ $(( $(date +%d) % 3 )) -eq 0 ]]; then
    sudo dnf autoremove -y
fi

flatpak update -y >> "$LOG_FILE" 2>&1
conda update --all -y >> "$LOG_FILE" 2>&1
