extends Control

func set_win(string):
		get_node("MarginContainer/VBoxContainer/winner_text").clear()
		get_node("MarginContainer/VBoxContainer/winner_text").append_text("[center]" + string + " Wins [/center]")

func _on_button_pressed(): 
		var root_node = get_tree().root
		var scene_node = root_node.get_node("Restart Menu")
		scene_node.queue_free()
		
		var new_scene = load("res://Env/env.tscn").instantiate()
		root_node.add_child(new_scene)
