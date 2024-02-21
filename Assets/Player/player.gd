extends "res://Assets/tank.gd"

func turret_rotate(delta):
	pass
	
func player_input(delta):
	velocity = Vector2(0,0)
	var x = 0
	var y = 0
	if Input.is_action_pressed('up'):
		y -= speed
	if Input.is_action_pressed('down'):
		y += speed
	if Input.is_action_pressed('right'):
		x += speed
	if Input.is_action_pressed('left'):
		x -= speed
	velocity = Vector2(x, y)
	
	if Input.is_action_pressed('turret_turn'):
		$Turret.rotate(-0.1)
		
	if Input.is_action_just_pressed('shoot'):
		shot()
