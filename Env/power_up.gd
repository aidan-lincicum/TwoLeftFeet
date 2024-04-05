extends Area2D

var rng = RandomNumberGenerator.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _on_body_entered(area):
	if area.name.begins_with("Player"):
		area.get_power_up(100,"max_hearts")
		queue_free()
	if area.name.begins_with("StaticBody2D"):
		queue_free()
	if area.name.begins_with("power_up"):
		queue_free()
