extends AnimatedSprite2D


func _ready():
	set_frame(3)

func _on_Player2_hit(hearts):
	set_frame(hearts)
	if(hearts == 0):
		get_tree().change_scene_to_file("res://Env/restart.tscn")
