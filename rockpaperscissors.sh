#!/bin/bash

puntos_usuario=0
puntos_cpu=0
marcador=""
alias=""
contador_rondas=0

# Generamos la opción random de la CPU
function jugada_cpu() {
    opciones=("piedra" "papel" "tijera")
    echo ${opciones[$((RANDOM % 3))]}
}

# Generamos la opción amañada de la CPU
function jugadon_cpu() {
    local jugada_usuario=$1
    case $jugada_usuario in
        "piedra") echo "papel" ;;
        "papel") echo "tijera" ;;
        *) echo "piedra" ;;
    esac
}

# Función para determinar el ganador de la ronda legal
function quien_gana_legal() {
    local jugada_usuario=$1
    local jugada_cpu=$2
    
    if [[ $jugada_usuario == $jugada_cpu ]]; then
        echo "Empate"
    elif [[ ($jugada_usuario == "piedra" && $jugada_cpu == "tijera") || 
            ($jugada_usuario == "papel" && $jugada_cpu == "piedra") || 
            ($jugada_usuario == "tijera" && $jugada_cpu == "papel") ]]; then
        echo "Ganaste"
    else
        echo "Perdiste"
    fi
}

# Función para actualizar el marcador y mostrar el resultado
function actualizar_marcador() {
    local resultado=$1
    
    case $resultado in
        "Ganaste")
            puntos_usuario=$((puntos_usuario + 1))
            ;;
        "Perdiste")
            puntos_cpu=$((puntos_cpu + 1))
            ;;
    esac
    
    marcador="CPU: $puntos_cpu vs $alias: $puntos_usuario"
    echo $marcador
}

# Función para jugar en modo "Mejor de 5"
function modo_5rondas() {
    echo "Hola $alias, has elegido el modo de juego: Mejor de 5"
    
    while [[ $contador_rondas -lt 5 ]]; do
        echo "Ronda $((contador_rondas + 1)) - $marcador"
        echo "Elige tu jugada (piedra, papel, tijera): "
        read jugada_usuario
        
        jugada_cpu=$(jugada_cpu)
        echo "La CPU elige: $jugada_cpu"
        
        resultado=$(quien_gana_legal $jugada_usuario $jugada_cpu)
        echo $resultado
        
        actualizar_marcador $resultado
        
        contador_rondas=$((contador_rondas + 1))
    done
    
    if [[ $puntos_cpu -gt $puntos_usuario ]]; then
        echo "¡Fin del juego, perdiste!"
    elif [[ $puntos_usuario -gt $puntos_cpu ]]; then
        echo "¡Fin del juego, ganaste!"
    else
        echo "¡Fin del juego, empate!"
    fi
}

# Función para jugar en modo "Infinito"
function modo_infinito() {
    echo "Hola $alias, has elegido el modo de juego: Infinito"
    
    while true; do
        echo "Ronda $((contador_rondas + 1)) - $marcador"
        echo "Elige tu jugada (piedra, papel, tijera): "
        read jugada_usuario
        
        jugada_cpu=$(jugada_cpu)
        echo "La CPU elige: $jugada_cpu"
        
        resultado=$(quien_gana_legal $jugada_usuario $jugada_cpu)
        echo $resultado
        
        actualizar_marcador $resultado
        
        contador_rondas=$((contador_rondas + 1))
    done
}

# Función para jugar en modo "Imposible"
function modo_imposible() {
    echo "Hola $alias, has elegido el modo de juego: Imposible. Espero que sepas manejar tu frustración"
    
    while true; do
        echo "Ronda $((contador_rondas + 1)) - $marcador"
        echo "Elige tu jugada (piedra, papel, tijera): "
        read jugada_usuario
        
        jugada_cpu=$(jugadon_cpu $jugada_usuario)
        echo "La CPU elige: $jugada_cpu"
        
        puntos_cpu=$((puntos_cpu + 1))
        marcador="CPU: $puntos_cpu vs $alias: $puntos_usuario"
        echo $marcador
        
        contador_rondas=$((contador_rondas + 1))
    done
}

# Función para elegir la dificultad
function elegir_dificultad() {
    echo "Introduce tu alias:"
    read alias
    
    echo "Elije el modo de juego (Mejor de 5, Infinito, Imposible): "
    read eleccion_dificultad
    
    # nocasematch para que sea más user-friendly
    shopt -s nocasematch
    
    case $eleccion_dificultad in
        "mejor de 5")
            modo_5rondas
            ;;
        "infinito")
            modo_infinito
            ;;
        "imposible")
            modo_imposible
            ;;
        *)
            echo "Opción no válida"
            ;;
    esac
    
    # Desactivamos nocasematch
    shopt -u nocasematch
}

# Inicio del juego
echo "Bienvenido al juego de Piedra, Papel, Tijera"
elegir_dificultad
