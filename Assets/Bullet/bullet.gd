extends CharacterBody2D

@export var speed : int
@export var timer : float # timer time is in p_bullet timer wait time variable 
@export var damage : int

func start(_position, _direction,_speed,_damage):
	position = _position
	rotation = _direction.angle()
	damage = _damage
	$Timer.wait_time = timer
	velocity = _direction * _speed
	$Timer.timeout.connect(on_timer_timeout)
	

func on_timer_timeout():
	queue_free()

func _process(delta):
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		if collider.get("name").begins_with("p_bullet"):
			collider.queue_free()
			queue_free()
		elif collider.get("name").begins_with("Player"):
			hit(collider)
		elif collider.get("name").begins_with("Static"):
			ricochet(collision)


func hit(collider):
	collider.is_hit(damage)
	queue_free()
	
func ricochet(collision):
	var reflect = collision.get_remainder().bounce(collision.get_normal())
	velocity = velocity.bounce(collision.get_normal())
	move_and_collide(reflect)
