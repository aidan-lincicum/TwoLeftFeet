extends Control

var new_scene = preload("res://Env/character_picker.tscn")
var help_scene = preload("res://Env/howToPlay.tscn")

#Changes scene to character_picker when start button is pressed
func _on_start_pressed():
	var root_node = get_tree().root
	var scene_node = root_node.get_node("start_screen")

	var new_scene_instance = new_scene.instantiate()
	scene_node.queue_free()
	root_node.add_child(new_scene_instance)

#Quits the game when quit button is pressed
func _on_quit_pressed():
	get_tree().quit()


func _on_help_pressed():
	var root_node = get_tree().root
	var scene_node = root_node.get_node("start_screen")
	scene_node.queue_free()
	
	var help_scene_instance = help_scene.instantiate()
	root_node.add_child(help_scene_instance)
