extends "res://Assets/tank.gd"

func _enter_tree():
	set_multiplayer_authority(name.to_int())

func player_input():
	if is_multiplayer_authority():
		velocity = Vector2(0,0)
		var x = 0
		var y = 0
		if Input.is_action_pressed('up2'):
			y -= 1
		if Input.is_action_pressed('down2'):
			y += 1
		if Input.is_action_pressed('right2'):
			x += 1
		if Input.is_action_pressed('left2'):
			x -= 1
		velocity = Vector2(x, y).normalized() * speed
		
		if Input.is_action_pressed('turret_turn2'):
			$Turret.rotate(rotation_speed)
			
		if Input.is_action_pressed('shoot2'):
			shoot()
