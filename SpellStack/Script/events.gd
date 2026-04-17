extends Node

#game manager signal
signal restart_game
signal start_game

#events de player
signal player_health_changed(current, max)

#events d'ennemi
signal attack_animation_trigger
signal death_animation_trigger
signal death_animation_ended
