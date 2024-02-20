extends "res://Assets/tank.gd"


func player_input(delta):
	var dir = 0
	if Input.is_action_pressed('turn_right'):
		dir += 0
	if Input.is_action_pressed('turn_left'):
		dir -= 1
	rotation += rotation_speed * dir * delta
	velocity = Vector2(0,0).rotated(rotation_speed)
	if Input.is_action_pressed('forward'):
		velocity = Vector2(speed, 0).rotated(rotation)
	if Input.is_action_pressed('back'):
		velocity = Vector2(-speed/2, 0).rotated(rotation)
