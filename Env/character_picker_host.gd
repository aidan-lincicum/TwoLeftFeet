extends Control

var classArray = ["Sniper", "Rifler", "Shotgun"] #Holds the names of player classes
var p1Pointer = 1 # Index of the selected player class for player 1
var p1Ready = false
var buttonIcon = preload("res://Env/readybtn.png")
var selectedButtonIcon = preload("res://Env/ready_select.png")
var riflerDescription1 = preload("res://Env/rifler1.png")
var shotgunDescription1 = preload("res://Env/shotgun1.png")
var sniperDescription1 = preload("res://Env/sniper1.png")

#Changes scene when both p1 and p2 are ready
func _process(_delta):
	if(p1Ready):
		var root_node = get_tree().root
		var scene_node = root_node.get_node("CharacterPicker")
		scene_node.queue_free()

		var new_scene = load("res://Env/mult_env.tscn").instantiate()
		new_scene.set_player_classes(classArray[p1Pointer], "Rifler")
		root_node.add_child(new_scene)

#Toggles player1 between ready and not ready states
func _on_ready_1_pressed():
	if(!p1Ready):
		p1Ready = true
		$MarginContainer/VBoxContainer/HBoxContainer/ready1.set_button_icon(selectedButtonIcon)
	else:
		p1Ready = false
		$MarginContainer/VBoxContainer/HBoxContainer/ready1.set_button_icon(buttonIcon)

#Changes the class type when the ready button is not selected
func _on_left_1_pressed():
	if(!p1Ready):
		if(p1Pointer == 0):
			p1Pointer = 2
		else: 
			p1Pointer -= 1
	update_p1_description()

func _on_right_1_pressed():
	if(!p1Ready):
		if(p1Pointer == 2):
			p1Pointer = 0
		else: 
			p1Pointer += 1
	update_p1_description()

func update_p1_description():
	match p1Pointer:
		0:
			$MarginContainer/VBoxContainer/HBoxContainer2/p1Description.texture = sniperDescription1
		1: 
			$MarginContainer/VBoxContainer/HBoxContainer2/p1Description.texture = riflerDescription1
		2:
			$MarginContainer/VBoxContainer/HBoxContainer2/p1Description.texture = shotgunDescription1
