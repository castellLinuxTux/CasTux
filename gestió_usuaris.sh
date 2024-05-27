#!/bin/bash

# Función para mostrar el menú principal
mostrar_menu() {
    opc=$(zenity --list --title="Gestió d'Usuaris" --text="Seleccioneu una opció:" \
        --column="Opció" --column="Descripció" \
        --width=600 --height=400 \
        "Afegir" "Afegir un nou usuari" \
        "Eliminar" "Eliminar un usuari existent" \
        "Llistar" "Llistar usuaris" \
        "Anterior Pantalla" "Tornar al menú de l'eina" \
        "Sortir" "Sortir de la gestió d'usuaris")

    case $opc in
        "Afegir") afegir_usuari ;;
        "Eliminar") eliminar_usuari ;;
        "Llistar") llistar_usuaris ;;
        "Anterior Pantalla") bash menu_grafic.sh ;;
        "Sortir") exit 0 ;;
        *) zenity --error --text="Opció no vàlida.";;
    esac
}

# Función per afegir un usuari
afegir_usuari() {
    nom_usuari=$(zenity --entry --title="Afegir Usuari" --text="Introduïu el nom del nou usuari:")
    if [ -n "$nom_usuari" ]; then
        sudo adduser "$nom_usuari"
        if [ $? -eq 0 ]; then
            zenity --info --text="Usuari '$nom_usuari' afegit correctament."
        else
            zenity --error --text="Error en afegir l'usuari '$nom_usuari'."
        fi
    fi
    mostrar_menu
}

# Función per eliminar un usuari
eliminar_usuari() {
    nom_usuari=$(zenity --entry --title="Eliminar Usuari" --text="Introduïu el nom de l'usuari a eliminar:")
    if [ -n "$nom_usuari" ]; then
        sudo deluser "$nom_usuari"
        if [ $? -eq 0 ]; then
            zenity --info --text="Usuari '$nom_usuari' eliminat correctament."
        else
            zenity --error --text="Error en eliminar l'usuari '$nom_usuari'."
        fi
    fi
    mostrar_menu
}

# Función per llistar els usuaris
llistar_usuaris() {
    usuaris=$(cut -d: -f1 /etc/passwd)
    zenity --info --title="Llista d'Usuaris" --text="Usuaris del sistema:\n$usuaris"
    mostrar_menu
}

mostrar_menu
