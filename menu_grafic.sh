#!/bin/bash

# Función para mostrar el menú principal
mostrar_menu_principal() {
    opc=$(zenity --list --title="Eina Gràfica" --text="Selecciona una opció: " \
        --column="Nom" --column="Descripció"\
        --width=700 --height=500 \
        "Usuaris" "Gestió d'usuaris" \
        "Grups" "Gestió de Grups" \
        "Software" "Gestió de Programari" \
        "Xarxa" "Gestió de Xarxa" \
        "Info Ordinador" "Veure informació del sistema" \
        "Manual eina gràfica" "Veure el manual de l'eina gràfica" \
        "Sortir" "Sortir de l'eina")

    case $opc in
        "Usuaris") bash gestio_users.sh ;;
        "Grups") bash gestio_grups.sh ;;
        "Software") bash gestio_software.sh ;;
        "Xarxa") bash gestio_xarxa.sh ;;
        "Info Ordinador") bash info_system.sh ;;
        "Manual eina gràfica") xdg-open https://sintesi.inscastellbisbal.net/castelllinux/2-3-recurs-compartit/ ;;
        "Sortir") exit 0 ;;
        *) zenity --error --text="Opció no valida." ;;
    esac
}

# Función para ejecutar un script
ejecutar_script() {
    script="$1"
    if [ -x "$script" ]; then
        ./"$script"
    else
        zenity --error --text="No es pot executar el script '$script'."
    fi
    mostrar_menu_principal
}

# Mostrar el menú principal
mostrar_menu_principal
