#!/bin/bash

# Función para mostrar el menú principal
mostrar_menu() {
    opc=$(zenity --list --title="Gestió de Grups" --text="Seleccioneu una opció:" \
        --column="Opció" --column="Descripció" \
        --width=600 --height=400 \
        "Afegir" "Afegir un nou grup" \
        "Eliminar" "Eliminar un grup existent" \
        "Llistar" "Llistar grups" \
        "Anterior Pantalla" "Tornar al menú de l'eina" \
        "Sortir" "Sortir de la gestió de grups")

    case $opc in
        "Afegir") afegir_grup ;;
        "Eliminar") eliminar_grup ;;
        "Llistar") llistar_grups ;;
        "Anterior Pantalla") bash menu_grafic.sh ;;
        "Sortir") exit 0 ;;
        *) zenity --error --text="Opció no vàlida." ;;
    esac
}

# Función per afegir un grup
afegir_grup() {
    nom_grup=$(zenity --entry --title="Afegir Grup" --text="Introduïu el nom del nou grup:")
    if [ -n "$nom_grup" ]; then
        sudo addgroup "$nom_grup"
        if [ $? -eq 0 ]; then
            zenity --info --text="Grup '$nom_grup' afegit correctament."
        else
            zenity --error --text="Error en afegir el grup '$nom_grup'."
        fi
    fi
    mostrar_menu
}

# Función per eliminar un grup
eliminar_grup() {
    nom_grup=$(zenity --entry --title="Eliminar Grup" --text="Introduïu el nom del grup a eliminar:")
    if [ -n "$nom_grup" ]; then
        sudo delgroup "$nom_grup"
        if [ $? -eq 0 ]; then
            zenity --info --text="Grup '$nom_grup' eliminat correctament."
        else
            zenity --error --text="Error en eliminar el grup '$nom_grup'."
        fi
    fi
    mostrar_menu
}

# Función per llistar els grups
llistar_grups() {
    grups=$(cut -d: -f1 /etc/group)
    zenity --info --title="Llista de Grups" --text="Grups del sistema:\n$grups"
    mostrar_menu
}

mostrar_menu1,1           Top


