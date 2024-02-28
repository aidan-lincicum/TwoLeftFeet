extends CharacterBody2D

@export var speed : int
@export var timer : float

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Timer.wait_time = timer
	velocity = _direction * speed
	var timer = get_node("Timer")
	timer.timeout.connect(on_timer_timeout)
	

func on_timer_timeout():
	queue_free()

func _process(delta):
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		if collider.get("name").begins_with("Player"):
			hit(collider)
		else:
			ricochet(collision)


func hit(collider):
	collider.is_hit()
	queue_free()
	
func ricochet(collision):
	var reflect = collision.get_remainder().bounce(collision.get_normal())
	velocity = velocity.bounce(collision.get_normal())
	move_and_collide(reflect)


 


