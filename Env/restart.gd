extends Control

#Sets text box to contain correct winner
func set_win(string):
		$MarginContainer/VBoxContainer/winner_text.clear()
		$MarginContainer/VBoxContainer/winner_text.append_text("[center]" + string + " Wins [/center]")

#Restarts the game by switching scene to env
func _on_button_pressed(): 
		var root_node = get_tree().root
		var scene_node = root_node.get_node("Restart Menu")
		scene_node.queue_free()
		
		var new_scene = load("res://Env/main_menu.tscn").instantiate()
		root_node.add_child(new_scene)
