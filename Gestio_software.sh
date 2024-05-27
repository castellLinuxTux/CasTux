#!/bin/bash

# Función para mostrar el menú principal
mostrar_menu() {
    opc=$(zenity --list --title="Gestió de Programari" --text="Seleccioneu una opció:" \
        --column="Opció" --column="Descripció" \
        --width=600 --height=400 \
        "Instal·lar" "Instal·lar un nou paquet" \
        "Desinstal·lar" "Desinstal·lar un paquet existent" \
        "Actualitzar" "Actualitzar els paquets" \
        "Anterior Pantalla" "Tornar al menú de l'eina" \
        "Sortir" "Sortir del gestor de programari")

    case $opc in
        "Instal·lar") instalar_paquet ;;
        "Desinstal·lar") desinstalar_paquet ;;
        "Actualitzar") actualitzar_paquets ;;
        "Anterior Pantalla") bash menu_grafic.sh ;;
        "Sortir") exit 0 ;;
        *) zenity --error --text="Opció no vàlida." ;;
    esac
}

# Función para instalar un paquete
instalar_paquet() {
    paquet=$(zenity --entry --title="Instal·lar Paquet" --text="Introduïu el nom del paquet per instal·lar:")
    if [ -n "$paquet" ]; then
        if sudo apt-get install -y "$paquet"; then
            zenity --info --text="Paquet '$paquet' instal·lat correctament."
        else
            zenity --error --text="Error en instal·lar el paquet '$paquet'."
        fi
    fi
    mostrar_menu
}

# Función per desinstal·lar un paquet
desinstalar_paquet() {
    paquet=$(zenity --entry --title="Desinstal·lar Paquet" --text="Introduïu el nom del paquet per desinstal·lar:")
    if [ -n "$paquet" ]; then
        if sudo apt-get remove -y "$paquet"; then
            zenity --info --text="Paquet '$paquet' desinstal·lat correctament."
        else
            zenity --error --text="Error en desinstal·lar el paquet '$paquet'."
        fi
    fi
    mostrar_menu
}

# Función per actualitzar els paquets
actualitzar_paquets() {
    if sudo apt-get update && sudo apt-get upgrade -y; then
        zenity --info --text="Paquets actualitzats correctament."
    else
        zenity --error --text="Error en actualitzar els paquets."
    fi
    mostrar_menu
}

# Mostrar el menú per primera vegada
mostrar_menu
                                         
                                         
