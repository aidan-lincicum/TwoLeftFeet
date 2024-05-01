extends Control

var classArray = ["Sniper", "Rifler", "Shotgun"] #Holds the names of player classes
var p2Pointer = 0 # Index of the selected player class for player 2
var p2Ready = false
var buttonIcon = preload("res://Env/readybtn.png")
var selectedButtonIcon = preload("res://Env/ready_select.png")
var riflerDescription2 = preload("res://Env/rifler2.png")
var shotgunDescription2 = preload("res://Env/shotgun2.png")
var sniperDescription2 = preload("res://Env/sniper2.png")

#Changes scene when both p1 and p2 are ready
func _process(_delta):
	if(p2Ready):
		var root_node = get_tree().root
		var scene_node = root_node.get_node("CharacterPicker")
		scene_node.queue_free()

		var new_scene = load("res://Env/mult_env.tscn").instantiate()
		root_node.add_child(new_scene)


#Toggles player2 between ready and not ready states
func _on_ready_2_pressed():	
	if(!p2Ready):
		p2Ready = true
		$MarginContainer/VBoxContainer/HBoxContainer/ready2.set_button_icon(selectedButtonIcon)
	else:
		p2Ready = false
		$MarginContainer/VBoxContainer/HBoxContainer/ready2.set_button_icon(buttonIcon)

func _on_left_2_pressed():
	if(!p2Ready):
		if(p2Pointer == 0):
			p2Pointer = 2
		else: 
			p2Pointer -= 1
	update_p2_description()

func _on_right_2_pressed():
	if(!p2Ready):
		if(p2Pointer == 2):
			p2Pointer = 0
		else: 
			p2Pointer += 1
	update_p2_description()

func update_p2_description():
	match p2Pointer:
		0:
			$MarginContainer/VBoxContainer/HBoxContainer2/p2Description.texture = sniperDescription2
		1: 
			$MarginContainer/VBoxContainer/HBoxContainer2/p2Description.texture = riflerDescription2
		2:
			$MarginContainer/VBoxContainer/HBoxContainer2/p2Description.texture = shotgunDescription2
		
