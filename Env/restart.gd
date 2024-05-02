extends Control

var new_scene = preload("res://Env/character_picker.tscn")

#Sets text box to contain correct winner
func set_win(string):
		if(string == "Player 1"):
			$MarginContainer/VBoxContainer/Player1.show()
		else:
			$MarginContainer/VBoxContainer/Player2.show()

#Restarts the game by switching scene to env
func _on_button_pressed(): 
		var root_node = get_tree().root
		var scene_node = root_node.get_node("Restart Menu")
		scene_node.queue_free()
		
		var new_scene_instance = new_scene.instantiate()
		root_node.add_child(new_scene_instance)

# Quit game
func _on_quit_pressed():
	get_tree().quit()
