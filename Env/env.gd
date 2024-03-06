extends Node2D

@export var power_up: PackedScene

var power_timer_is_running = false

func _on_Tank_shoot(bullet, _position, _direction):
	var b = bullet.instantiate()
	add_child(b)
	b.start(_position, _direction)

func _process(delta):
	var rng = RandomNumberGenerator.new()
	if(!power_timer_is_running):
		var my_random_number = rng.randf_range(0, 1)
		makeTimer(my_random_number)
		
func _ready():
	var rng = RandomNumberGenerator.new()
	var my_random_number = rng.randf_range(0, 1)
	makeTimer(my_random_number)
	var timer = get_node("powerUpTimer")
	
func makeTimer(amount_time):
	$powerUpTimer.wait_time = amount_time
	print($powerUpTimer.wait_time)
	$powerUpTimer.timeout.connect(_on_timer_timeout)
	power_timer_is_running = true

func spawn_power_up():
	print("spawnPowerUP")
	var power_up = power_up.instantiate()
	power_up.start()
	
func _on_timer_timeout():
	print("timer timout")
	spawn_power_up()
	power_timer_is_running = false
