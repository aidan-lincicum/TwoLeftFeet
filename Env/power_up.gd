extends Area2D

var rng = RandomNumberGenerator.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func start():
	print("raedy")
	position = Vector2(0,0)
	
func _on_body_entered(area):
	if area.name.begins_with("Player"):
		var my_random_number = rng.randi_range(1, 3)
		if(my_random_number == 1):
			area.get_power_up(800,"speed")
		if(my_random_number == 2):
			area.get_power_up(0.1,"turret_cd")
		if(my_random_number == 3):
			area.get_power_up(3,"max_hearts")
		queue_free()
	if area.name.begins_with("StaticBody2D"):
		queue_free()
	if area.name.begins_with("power_up"):
		queue_free()
