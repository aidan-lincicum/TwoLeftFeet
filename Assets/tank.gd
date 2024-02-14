extends CharacterBody2D

@export var speed: int
@export var rotation_speed: float

func player_input(delta):
	pass

func _physics_process(delta):
	player_input(delta)
	move_and_slide()
