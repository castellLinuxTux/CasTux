#!/bin/bash

# Funció per mostrar el menú principal
mostrar_menu_principal() {
    opc=$(zenity --list --title="Gestió de Xarxa" --text="Seleccioneu una opció:" \
        --column="Opció" --column="Descripció" \
        --width=600 --height=400 \
        "Veure Configuració" "Veure la configuració de xarxa" \
        "Configurar IP" "Configurar adreça IP" \
        "Configurar Porta d'Enllaç" "Configurar la porta d'enllaç" \
        "Configurar DNS" "Configurar servidors DNS" \
        "Anterior Pantalla" "Tornar al menu de l'eina" \
        "Sortir" "Sortir del menú")

    case $opc in
        "Veure Configuració") veure_configuracio ;;
        "Configurar IP") configurar_ip ;;
        "Configurar Porta d'Enllaç") configurar_porta_enllac ;;
        "Configurar DNS") configurar_dns ;;
        "Anterior Pantalla") bash menu_grafic.sh ;;
        "Sortir") exit 0 ;;
        *) zenity --error --text="Opció no vàlida." ;;
    esac
}

# Funció per veure la configuració de xarxa
veure_configuracio() {
    info_ip=$(ip addr show)
    zenity --info --title="Configuració de Xarxa" --text="$info_ip"
    mostrar_menu_principal
}

# Funció per configurar la adreça IP
configurar_ip() {
    nova_ip=$(zenity --entry --title="Configurar IP" --text="Introduïu la nova adreça IP:")
    if [ -n "$nova_ip" ]; then
        sudo ip addr add "$nova_ip" dev eth0
        if [ $? -eq 0 ]; then
            zenity --info --text="Adreça IP '$nova_ip' configurada correctament."
        else
            zenity --error --text="Error en configurar la adreça IP."
        fi
    fi
    mostrar_menu_principal
}

# Funció per configurar la porta d'enllaç
configurar_porta_enllac() {
    nova_porta=$(zenity --entry --title="Configurar Porta d'Enllaç" --text="Introduïu la nova porta d'enllaç:")
    if [ -n "$nova_porta" ]; then
        sudo ip route add default via "$nova_porta"
        if [ $? -eq 0 ]; then
            zenity --info --text="Porta d'enllaç '$nova_porta' configurada correctament."
        else
            zenity --error --text="Error en configurar la porta d'enllaç."
        fi
       fi
    mostrar_menu_principal
}

# Funció per configurar els servidors DNS
configurar_dns() {
    nou_dns=$(zenity --entry --title="Configurar DNS" --text="Introduïu el nou servidor DNS:")
    if [ -n "$nou_dns" ]; then
        echo "nameserver $nou_dns" | sudo tee /etc/resolv.conf > /dev/null
        if [ $? -eq 0 ]; then
            zenity --info --text="Servidor DNS '$nou_dns' configurat correctament."
        else
            zenity --error --text="Error en configurar el servidor DNS."
        fi
    fi
    mostrar_menu_principal
}

# Mostrar el menú principal
mostrar_menu_principal
