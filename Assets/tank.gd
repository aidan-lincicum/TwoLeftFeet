extends CharacterBody2D

@export var speed: int
@export var rotation_speed: float
@export var bullet : PackedScene
@export var turret_cd: float

signal trigger
signal hit(hearts)

#Trying to make health packs reset the health sprites
#but can't figure it out
#signal health_pack(hearts)


var rng = RandomNumberGenerator.new()
var max_hearts = 3
var hearts = max_hearts
var cd = false 
var type_of_tank = "not assigned"
var bullet_speed = 0
var bullet_damage = 0
var is_sniper = false
var isInvincible = false
var isBlink = false
var burst_fire_count = 1
var numShot = 0


func player_input():
	pass
	
func shoot():
	if not cd:
		print(burst_fire_count)
		cd = true
		$Reload.start()
		var dir = Vector2(1, 0).rotated($Turret.global_rotation)
		emit_signal('trigger', bullet, $Turret/Gun.global_position, dir,bullet_speed,bullet_damage,type_of_tank)
		if(type_of_tank == "Assassin" && burst_fire_count < 3):
			$burstFire.start()
		

func _on_burst_fire_timeout():
	burst_fire_count += 1
	cd = false
	shoot()

#Called by bullet when it makes contact with a tank
func is_hit(damage):
	if(!isInvincible):
		$invincibility.start()
		isInvincible = true
		hearts -= damage
		emit_signal("hit", hearts, max_hearts)
		if hearts <= 0:
			# alive = false
			queue_free()

func _physics_process(_delta):
	player_input()
	move_and_slide()
	
	#Starts tank blinking when hit
	if(isInvincible && !isBlink):
		self.set_modulate(Color(255,255,255,255))
		$blinkOn.start()
		isBlink = true


func set_class_type(type): 
	if(type == "Sniper"):
		type_of_tank = "Sniper"
		max_hearts = 100
		hearts = max_hearts
		$Reload.wait_time = 2
		speed = 500
		bullet_speed = 3000
		bullet_damage = 70
		rotation_speed = -0.05
	elif(type == "Assassin"):
		type_of_tank = "Assassin"
		set_burst_fire()
		max_hearts = 75
		hearts = max_hearts
		$Reload.wait_time = 1
		speed = 1200
		bullet_speed = 1500
		bullet_damage = 25
		rotation_speed = -0.05
	elif(type == "Balanced"):
		type_of_tank = "Balanced"
		max_hearts = 100
		hearts = max_hearts
		$Reload.wait_time = 0.5
		speed = 800
		bullet_speed = 1200
		bullet_damage = 34
	elif(type == "Heavy"):
		max_hearts = 100
		hearts = max_hearts
		$Reload.wait_time = 1.5
		speed = 1700
		bullet_speed = 2000
		bullet_damage = 70
		rotation_speed = -0.08



#When the timer for reload goes out,
#reset the cooldown to be able to shoot again
func _on_Reload_timeout():
	burst_fire_count = 1
	cd = false

func set_burst_fire():
	return

func get_power_up(var_type):
	$powerUpLength.start()
	if(var_type == "hearts"):
		hearts = max_hearts
		#Trying to make hearts reset appear on health bar
		#emit_signal("health_pack", hearts, max_hearts)
	
func printHearts():
	print("hearts: " + str(hearts) + "max_hearts: " + str(max_hearts))
	
func set_default_stats():
	set_class_type(type_of_tank)

func _on_power_up_length_timeout():
	set_default_stats()

func _on_invincibility_timeout():
	isInvincible = false

#Flips between blinkOff and blinkOn while player is invincible
func _on_blink_off_timeout():
	if(isInvincible):
		self.set_modulate(Color(255,255,255,255))
		$blinkOn.start()
	else:
		isBlink = false

func _on_blink_on_timeout():
	self.set_modulate(Color(1,1,1,1))
	if(isInvincible):
		$blinkOff.start()
	else:
		isBlink = false

