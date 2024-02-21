extends Area2D

@export var speed : int
@export var timer : float

var velocity = Vector2()

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Timer.wait_time = timer
	velocity = _direction * speed
	
func _process(delta):
	position += velocity * delta

func _on_Timer_timeout():
	queue_free()
