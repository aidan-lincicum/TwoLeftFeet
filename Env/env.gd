extends Node2D

@export var power_up: PackedScene

var rng = RandomNumberGenerator.new()
var power_up_x_position
var power_up_y_position

func _on_Tank_shoot(bullet, _position, _direction,_speed,_damage,_type_of_tank):
	var b = bullet.instantiate()
	add_child(b)
	b.start(_position, _direction,_speed,_damage,_type_of_tank)

func _ready():
	$powerUpTimer.wait_time = 10

func spawn_power_up():
	var power_up_instance = power_up.instantiate()
	add_child(power_up_instance)
	power_up_x_position = rng.randf_range(-1700,1700)
	power_up_y_position = rng.randf_range(-1620,1620)
	power_up_instance.position = Vector2(power_up_x_position,power_up_y_position)

func _on_power_up_timer_timeout():
	spawn_power_up()
	$powerUpTimer.wait_time = 10

func set_player_classes(player1, player2):
	$Player1.set_class_type(player1)
	$Player2.set_class_type(player2)

func disable_player():
	$Player1.disabled = true
	$Player2.disabled = true
	$Player1.velocity = Vector2(0,0)
	$Player2.velocity = Vector2(0,0)

func _on_player_2_player_dead():
	disable_player()

func _on_player_1_player_1_dead():
	disable_player()
