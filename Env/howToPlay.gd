extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_pressed():
	var root_node = get_tree().root
	var scene_node = root_node.get_node("HowToPlay")
	scene_node.queue_free()
	
	var new_scene = load("res://Env/start_screen.tscn").instantiate()
	root_node.add_child(new_scene)
