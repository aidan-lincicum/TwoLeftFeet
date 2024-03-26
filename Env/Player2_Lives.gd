extends AnimatedSprite2D


func _ready():
	set_frame(3) 

func _on_Player2_hit(hearts):
	set_frame(hearts)
	if(hearts <= 0):
		var root_node = get_tree().root
		var scene_node = root_node.get_node("Env")
		scene_node.queue_free()
		
		var new_scene = load("res://Env/restart.tscn").instantiate()
		root_node.add_child(new_scene)
		new_scene.set_win("Player 1")
