#!/bin/bash

SOURCE="/home/vboxuser/tp_Linux/Logs"
DEST="/home/vboxuser/tp_Linux/Backup"

mkdir -p "$DEST"

cp -r "$SOURCE/"* "$DEST"
