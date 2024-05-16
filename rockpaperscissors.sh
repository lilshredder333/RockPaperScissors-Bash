#!/bin/bash

#Generamos la opción de la CPU
function eleccion_cpu(){
    opciones=("piedra", "papel", "tijera")
    eleccion_cpu=${opciones[$((RANDOM % 3))]}
    
}

#Funcion cheat
function quien_gana(){
    eleccion_usuario=$1
    eleccion_cpu=$2

    if [[ $eleccion_usuario == $eleccion_cpu ]]; then
        echo "Tremendo Empate"

    elif [[ ($eleccion_usuario == "piedra" && $eleccion_cpu == "tijera") || ($eleccion_usuario == "papel" && $eleccion_cpu == "piedra") || ($eleccion_usuario == "tijera" && $eleccion_cpu == "papel") ]]; then
        echo "¡Tremendisima partida, ganaste!"

    else 
        echo "¡Fuiste derrotado por la maquina!"
    fi
}

# Funcion main del juego
function jugar(){
    read -p "Elige tu jugada (piedra, papel, tijera): " $eleccion_usuario

    eleccion_cpu

    echo "La CPU elige: " $eleccion_cpu
    
    quien_gana $eleccion_usuario $eleccion_cpu
}

#Inicio del juego
echo "Bienvenido al juego de Piedra, Papel, Tijera"
jugar