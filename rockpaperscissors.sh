#!/bin/bash



puntos_usuario=0
puntos_cpu=0
marcador="CPU: $puntos_cpu vs $alias: $puntos_usuario"
mensaje_final=""
contador_rondas=0

#Generamos la opción random de la CPU
function jugada_cpu(){
    opciones=("piedra", "papel", "tijera")
    jugada_cpu=${opciones[$((RANDOM % 3))]}
    
}

 #Generamos la opción amañada de la CPU
 function jugadon_cpu(){

    jugada_usuario=$1

    if [[ $jugada_usuario = "piedra" ]]; then
            jugada_cpu="papel"
            

            elif [[ $jugada_usuario = "papel" ]]; then

                jugada_cpu="tijera"
                
        else 

            jugada_cpu="piedra"
            
        fi
 }

#Funcion revisar ganador legal
function quien_gana_legal(){
    
    jugada_usuario=$1
    jugada_cpu=$2
    
    if [[ $jugada_usuario == $jugada_cpu ]]; then
        echo "Tremendo Empate"
        
        
        elif [[ ($jugada_usuario == "piedra" && $jugada_cpu == "tijera") || ($jugada_usuario == "papel" && $jugada_cpu == "piedra") || ($jugada_usuario == "tijera" && $jugada_cpu == "papel") ]]; then
        gana_user
        
    else
        gana_cpu
    fi
    
    
}

#Funcion revisar ganador ilegal
function quien_gana_ilegal(){
    
    puntos_usuario=$1
    puntos_cpu=$2

    gana_cpu
}

function gana_cpu(){
    
    echo "Ronda: $contador_rondas ¡Fin del juego, perdiste!"
    puntos_cpu=$((puntos_cpu + 1))
    marcador="CPU: $puntos_cpu vs $alias: $puntos_usuario"
    echo $marcador
}

function gana_user(){
    echo "Ronda: $contador_rondas ¡Fin del juego, ganaste!"
    puntos_usuario=$((puntos_usuario + 1))
    marcador="CPU: $puntos_cpu vs $alias: $puntos_usuario"
    echo $marcador
}

function empate(){
    echo "Ronda: $contador_rondas ¡Fin del juego, vaya empate más feo!"
    marcador="CPU: $puntos_cpu vs $alias: $puntos_usuario"
    echo $marcador
}

function modo_5rondas() {
    
    echo "Hola "$alias", has elegido el modo de juego: Mejor de 5"
    
    
    while [[ $contador_rondas -lt 5 ]]; do
        echo "Ronda $contador_rondas - $marcador"
        echo "Elige tu jugada (piedra, papel, tijera): "
        read jugada_usuario
        
        jugada_cpu 
        
        echo "La CPU elige: " $jugada_cpu
        
        quien_gana_legal $jugada_usuario $jugada_cpu
        
        # Incrementa el contador de rondas
        contador_rondas=$((contador_rondas + 1))
    done
    
    if [[ $contador_rondas -eq 5 ]]; then
        
        if [[ $puntos_cpu -gt $puntos_usuario ]]; then
            
            gana_cpu
            
            elif [[ $puntos_cpu -lt $puntos_usuario  ]]; then
            
            gana_user
        else
            empate
        fi
    fi
}

function modo_infinito() {

    echo "Hola "$alias", has elegido el modo de juego: Modo infinito"
    
    marcador="CPU: $puntos_cpu vs $alias: $puntos_usuario"
    
    while [[ 1 -eq 1 ]]; do
        echo "Ronda $contador_rondas - $marcador"
        echo "Elige tu jugada (piedra, papel, tijera): "
        read jugada_usuario
        
        jugada_cpu
        
        echo "La CPU elige: " $jugada_cpu
        
        quien_gana_legal $jugada_usuario $jugada_cpu $puntos_usuario $puntos_cpu
        
        # Incrementa el contador de rondas
        contador_rondas=$((contador_rondas + 1))
    done
}

function modo_imposible() {
    
    
    echo "Hola "$alias", has elegido el modo de juego: Imposible. Espero que sepas manejar tu frustración"
    
    marcador="CPU: $puntos_cpu vs $alias: $puntos_usuario"
    
    while [[ 1 -eq 1 ]]; do
        echo "Ronda $contador_rondas - $marcador"
        echo "Elige tu jugada (piedra, papel, tijera): "
        read jugada_usuario
        
        jugadon_cpu $jugada_usuario
        
        echo "La CPU elige: " $jugada_cpu
        
        quien_gana_ilegal $puntos_usuario $puntos_cpu
        
        # Incrementa el contador de rondas
        contador_rondas=$((contador_rondas + 1))
    done
    
}

function elegir_dificultad(){
    echo "Introduce tu alias:"
    read alias
    echo "Elije el modo de juego (Mejor de 5, Infinito o Imposible): "
    read eleccion_dificultad
    
    # nocasematch para q sea mas user friendly :)
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
    
    # desactivamos
    shopt -u nocasematch
}

#Inicio del juego
echo "Bienvenido al juego de Piedra, Papel, Tijera"
elegir_dificultad