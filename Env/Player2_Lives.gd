extends AnimatedSprite2D

signal player_dead
var new_scene = preload("res://Env/restart.tscn")

func _ready():
	set_frame(10)

func _on_Player2_hit(hearts : float, max_hearts: float):
	set_frame(ceil((hearts/max_hearts)*10))
	if(hearts <= 0):
		$P2DeathTimer.start()
		emit_signal('player_dead')



func _on_p_2_death_timer_timeout():
	var root_node = get_tree().root
	var scene_node = root_node.get_node("Env")
	scene_node.queue_free()
	
	var new_scene_instance = new_scene.instantiate()
	root_node.add_child(new_scene_instance)
	new_scene.set_win("Player 1")
