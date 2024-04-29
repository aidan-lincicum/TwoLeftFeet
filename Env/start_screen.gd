extends Control

#Changes scene to character_picker when start button is pressed
func _on_start_pressed():
	var root_node = get_tree().root
	var scene_node = root_node.get_node("start_screen")

	var new_scene = load("res://Env/character_picker.tscn").instantiate()
	scene_node.queue_free()
	root_node.add_child(new_scene)

#Quits the game when quit button is pressed
func _on_quit_pressed():
	get_tree().quit()
