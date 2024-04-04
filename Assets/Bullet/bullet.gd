extends CharacterBody2D

@export var speed : int
@export var timer : float # timer time is in p_bullet timer wait time variable 
@export var damage : int

var num_bounces = 0

var type_of_tank

func start(_position, _direction,_speed,_damage,_type_of_tank):
	position = _position
	rotation = _direction.angle()
	damage = _damage
	type_of_tank = _type_of_tank
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
			num_bounces = num_bounces + 1
			if(num_bounces < 3 && type_of_tank == "Sniper"):
				ricochet(collision)
			else:
				queue_free()
			#if is_sniper == true:
				#
			#else:
				#queue_free()
			


func hit(collider):
	collider.is_hit(damage)
	queue_free()
	
func ricochet(collision):
	var reflect = collision.get_remainder().bounce(collision.get_normal())
	velocity = velocity.bounce(collision.get_normal())
	move_and_collide(reflect)
