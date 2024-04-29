extends CharacterBody2D

@export var speed : int
@export var timer : float # timer time is in p_bullet timer wait time variable 
@export var damage : int
@export var size : int

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
	$Explosion.spread = 180
	explode()

func _process(delta):
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		if collider.get("name").begins_with("p_bullet"):
			collider.queue_free()
			explode()
		elif collider.get("name").begins_with("Player"):
			explode()
			hit(collider)
		elif collider.get("name").begins_with("Static"):
			num_bounces = num_bounces + 1
			if(num_bounces < 3 && type_of_tank == "Sniper"):
				ricochet(collision)
			else:
				explode()

func hit(collider):
	collider.is_hit(damage)
	
func ricochet(collision):
	var reflect = collision.get_remainder().bounce(collision.get_normal())
	velocity = velocity.bounce(collision.get_normal())
	move_and_collide(reflect)
	
func explode():
	$Sprite2D.hide()
	$Trail.hide()
	self.set_collision_mask_value(1, false)
	self.set_collision_mask_value(2, false)
	$Explosion.direction = Vector2(-1,0).normalized()
	$Explosion.emitting = true
	velocity = Vector2(0,0)
	$Despawn.start()
	$Timer.stop()

func _on_despawn_timeout():
	queue_free()
