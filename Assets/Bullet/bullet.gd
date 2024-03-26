extends CharacterBody2D

@export var speed : int
@export var timer : float # timer time is in p_bullet timer wait

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Timer.wait_time = timer
	velocity = _direction * speed
	$Timer.timeout.connect(on_timer_timeout)
	

func on_timer_timeout():
	queue_free()

func _process(delta):
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		print(collider.get("name"))
		if collider.get("name").begins_with("Player"):
			hit(collider)
		else: if collider.get("name").begins_with("p_bullet"):
			queue_free()
			collider.queue_free()
		else: if collider.get("name").begins_with("Static"):
			ricochet(collision)


func hit(collider):
	collider.is_hit()
	queue_free()
	
func ricochet(collision):
	var reflect = collision.get_remainder().bounce(collision.get_normal())
	velocity = velocity.bounce(collision.get_normal())
	move_and_collide(reflect)


 


