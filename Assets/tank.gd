extends CharacterBody2D

@export var speed: int
@export var rotation_speed: float
@export var bullet : PackedScene
@export var turret_cd: float


signal trigger
signal hit(hearts)

# var alive = true
var rng = RandomNumberGenerator.new()
var max_hearts = 3
var hearts = max_hearts
var cd = false 
var type_of_tank = "not assigned"
var bullet_speed = 0
var bullet_damage = 0

func player_input(_delta):
	pass
	
func shoot():
	if not cd:
		cd = true
		$Reload.start()
		var dir = Vector2(1, 0).rotated($Turret.global_rotation)
		emit_signal('trigger', bullet, $Turret/Gun.global_position, dir,bullet_speed,bullet_damage)
		

func is_hit(damage):
	hearts -= damage
	emit_signal("hit", hearts)
	if hearts <= 0:
		# alive = false
		queue_free()

func _physics_process(delta):
	player_input(delta)
	move_and_slide()

func _ready():
	var my_random_number = rng.randi_range(1, 3)
	if(my_random_number == 1):
		type_of_tank = "sniper"
	elif(my_random_number == 2):
		type_of_tank = "assassin"
	elif(my_random_number == 3):
		type_of_tank = "heavy"
	elif(my_random_number == 4):
		type_of_tank = "balanced"
	set_class_type(type_of_tank)

func set_class_type(type): 
	print(type_of_tank)
	if(type == "sniper"):
		max_hearts = 100
		hearts = max_hearts
		$Reload.wait_time = 5
		speed = 300
		bullet_speed = 1000
		bullet_damage = 75
	elif(type == "assassin"):
		max_hearts = 100
		hearts = max_hearts
		$Reload.wait_time = 0.1
		speed = 600
		bullet_speed = 800
		bullet_damage = 10
	elif(type == "balanced"):
		max_hearts = 100
		hearts = max_hearts
		$Reload.wait_time = 0.5
		speed = 300
		bullet_speed = 400
		bullet_damage = 34
	elif(type == "heavy"):
		max_hearts = 200
		hearts = max_hearts
		$Reload.wait_time = 2
		speed = 200
		bullet_speed = 400
		bullet_damage = 34



func _on_Reload_timeout():
	cd = false
	
func get_power_up(var_change,var_type):
	$powerUpLength.start()
	if(var_type == "speed"):
		speed = var_change
	if(var_type == "turret_cd"):
		$Reload.wait_time = var_change
	if(var_type == "max_hearts"):
		max_hearts = var_change
	#if(var_type == "bullet_speed"):
		#bullet = var_change
		#how to change bullet speed??
	
func set_default_stats():
	set_class_type(type_of_tank)

func _on_power_up_length_timeout():
	
	set_default_stats()
	pass # Replace with function body.
