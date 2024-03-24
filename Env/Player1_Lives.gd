extends AnimatedSprite2D


func _ready():
	set_frame(3)

func _on_Player1_hit(hearts):
	set_frame(hearts)
