extends CharacterBody2D

@export var speed: int
@export var rotation_speed: float
@export var bullet : PackedScene
@export var turret_cd: float

signal trigger

var alive = true
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
	queue_free()

func _physics_process(delta):
	player_input(delta)
	move_and_slide()

func _ready():
	$Reload.wait_time = turret_cd

func _on_Reload_timeout():
	cd = false
