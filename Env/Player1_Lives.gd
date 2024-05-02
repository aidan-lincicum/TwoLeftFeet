extends AnimatedSprite2D

signal player_1_dead

func _ready():
	set_frame(11)

func _on_Player1_hit(hearts : float, max_hearts: float):
	set_frame(ceil((hearts/max_hearts)*11))
	if(hearts <= 0):
		$P1DeathTimer.start()
		emit_signal('player_1_dead')

func _on_p_1_death_timer_timeout():
	var root_node = get_tree().root
	var scene_node = root_node.get_node("Env")
	scene_node.queue_free()
	
	var new_scene = load("res://Env/restart.tscn").instantiate()
	root_node.add_child(new_scene)
	new_scene.set_win("Player 2")
