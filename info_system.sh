#!/bin/bash

# Obtenir informació del sistema
HOSTNAME=$(hostname)2>&1
KERNEL_VERSION=$(uname -r)2>&1
TOTAL_MEMORY=$(free -h | awk '/^Mem:/ {print $2}')2>&1

# Mostrar la informació utilitzant Zenity
zenity --info --title "Informació del sistema" --text "Nom de l'Host: $HOSTNAME\nVersió del Kernel: $KERNEL_VERSION\nMemòria Total: $TOTAL_MEMORY" 2>&1
