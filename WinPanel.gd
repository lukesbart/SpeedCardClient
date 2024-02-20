extends Control

var main

func _ready():
	main = get_node("..")
	
	

func _on_NewGame_pressed():
	main._restart_game()
