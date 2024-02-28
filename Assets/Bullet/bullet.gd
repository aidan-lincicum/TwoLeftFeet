extends CharacterBody2D

@export var speed : int
@export var timer : float

#var velocity = Vector2()

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Timer.wait_time = Timer
	velocity = _direction * speed
	var timer = get_node("Timer")
	timer.timeout.connect(on_timer_timeout)
	

func on_timer_timeout():
	queue_free()

func _process(delta):
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	
	if collision:
		var colliding_name = collision.get_collider().get("name")
		if colliding_name.begins_with("Player"):
			hit() 
		else:
			var reflect = collision.get_remainder().bounce(collision.get_normal())
			velocity = velocity.bounce(collision.get_normal())
			move_and_collide(reflect)


	
func hit():
	queue_free()
#func _on_body_entered(area):
	
	#if area.name == "StaticBody2D":
		#ricochet()

#want to add function for hit

#func ricochet():

 


