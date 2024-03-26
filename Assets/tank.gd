extends CharacterBody2D

@export var speed: int
@export var rotation_speed: float
@export var bullet : PackedScene
@export var turret_cd: float


signal trigger
signal hit(hearts)

# var alive = true
var max_hearts = 3
var hearts = max_hearts
var cd = false 

func player_input(delta):
	pass
	
func shoot():
	if not cd:
		cd = true
		$Reload.start()
		var dir = Vector2(1, 0).rotated($Turret.global_rotation)
		emit_signal('trigger', bullet, $Turret/Gun.global_position, dir)

func is_hit():
	hearts -= 1
	emit_signal("hit", hearts)
	if hearts <= 0:
		# alive = false
		queue_free()

func _physics_process(delta):
	player_input(delta)
	move_and_slide()

func _ready():
	$Reload.wait_time = turret_cd

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
	speed = 500
	$Reload.wait_time = 0.5

func _on_power_up_length_timeout():
	
	set_default_stats()
	pass # Replace with function body.
