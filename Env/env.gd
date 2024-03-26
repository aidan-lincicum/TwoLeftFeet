extends Node2D

@export var power_up: PackedScene

var power_timer_is_running = false
var rng = RandomNumberGenerator.new()
var power_up_x_position
var power_up_y_position

func _on_Tank_shoot(bullet, _position, _direction,_speed,_damage):
	var b = bullet.instantiate()
	add_child(b)
	b.start(_position, _direction,_speed,_damage)

func _process(delta):
	if(!power_timer_is_running):
		var my_random_number = rng.randf_range(5, 6)
		makeTimer(my_random_number)
		
func _ready():
	var random_time_amount = rng.randf_range(5, 6)
	makeTimer(random_time_amount)
	
func makeTimer(amount_time):
	$powerUpTimer.wait_time = amount_time
	power_timer_is_running = true

func spawn_power_up():
	var power_up_instance = power_up.instantiate()
	add_child(power_up_instance)
	power_up_x_position = rng.randf_range(-1700,1700)
	power_up_y_position = rng.randf_range(-1620,1620)
	power_up_instance.position = Vector2(power_up_x_position,power_up_y_position)
	
func _on_power_up_timer_timeout():
	spawn_power_up()
	power_timer_is_running = false

