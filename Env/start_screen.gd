extends Control

func _on_start_pressed():
	var root_node = get_tree().root
	var scene_node = root_node.get_node("start_screen")
	scene_node.queue_free()
	
	var new_scene = load("res://Env/main_menu.tscn").instantiate()
	root_node.add_child(new_scene)

func _on_quit_pressed():
	get_tree().quit()
