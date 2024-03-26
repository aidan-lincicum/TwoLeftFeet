extends "res://Assets/tank.gd"

func turret_rotate(delta):
	pass
	
func player_input(delta):
	velocity = Vector2(0,0)
	var x = 0
	var y = 0
	if Input.is_action_pressed('up'):
		y -= 1
	if Input.is_action_pressed('down'):
		y += 1
	if Input.is_action_pressed('right'):
		x += 1
	if Input.is_action_pressed('left'):
		x -= 1
	velocity = Vector2(x, y).normalized() * speed
	
	if Input.is_action_pressed('turret_turn'):
		$Turret.rotate(rotation_speed)
		
	if Input.is_action_pressed('shoot'): 
		shoot()
