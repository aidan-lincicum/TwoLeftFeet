extends CharacterBody2D

@export var speed: int
@export var rotation_speed: float
@export var bullet : PackedScene
@export var turret_cd: float

signal trigger
signal hit(hearts)

var rng = RandomNumberGenerator.new()
var max_hearts = 3
var hearts = max_hearts
var cd = false 
var type_of_tank = "not assigned"
var bullet_speed = 0
var bullet_damage = 0
var is_sniper = false

func player_input():
	pass
	
func shoot():
	if not cd:
		cd = true
		$Reload.start()
		var dir = Vector2(1, 0).rotated($Turret.global_rotation)
		emit_signal('trigger', bullet, $Turret/Gun.global_position, dir,bullet_speed,bullet_damage,type_of_tank)
		
		

#Called by bullet when it makes contact with a tank
func is_hit(damage):
	hearts -= damage
	emit_signal("hit", hearts, max_hearts)
	if hearts <= 0:
		# alive = false
		queue_free()

func _physics_process(_delta):
	player_input()
	move_and_slide()


func set_class_type(type): 
	if(type == "Sniper"):
		type_of_tank = "Sniper"
		max_hearts = 100
		hearts = max_hearts
		$Reload.wait_time = 2
		speed = 500
		bullet_speed = 3000
		bullet_damage = 70
		rotation_speed = -0.05
	elif(type == "Assassin"):
		type_of_tank = "Assassin"
		max_hearts = 75
		hearts = max_hearts
		$Reload.wait_time = 0.1
		speed = 1200
		bullet_speed = 1500
		bullet_damage = 25
		rotation_speed = -0.05
	elif(type == "Balanced"):
		type_of_tank = "Balanced"
		max_hearts = 100
		hearts = max_hearts
		$Reload.wait_time = 0.5
		speed = 800
		bullet_speed = 1200
		bullet_damage = 34
	elif(type == "Heavy"):
		max_hearts = 100
		hearts = max_hearts
		$Reload.wait_time = 1.5
		speed = 1700
		bullet_speed = 2000
		bullet_damage = 70
		rotation_speed = -0.08


#When the timer for reload goes out,
#reset the cooldown to be able to shoot again
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
