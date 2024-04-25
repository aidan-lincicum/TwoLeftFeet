extends Control

var classArray = ["Sniper", "Rifler", "Shotgun"] #Holds the names of player classes
var p1Pointer = -1 # Index of the selected player class for player 1
var p2Pointer = -1 # Index of the selected player class for player 2
var p1Ready = false
var p2Ready = false
var buttonIcon = preload("res://Env/readybtn.png")
var selectedButtonIcon = preload("res://Env/ready_select.png")

#Changes scene when both p1 and p2 are ready
func _process(_delta):
	if(p1Ready && p2Ready):
		var root_node = get_tree().root
		var scene_node = root_node.get_node("CharacterPicker")
		scene_node.queue_free()

		var new_scene = load("res://Env/env.tscn").instantiate()
		new_scene.set_player_classes(classArray[p1Pointer], classArray[p2Pointer])
		root_node.add_child(new_scene)

#Toggles player1 between ready and not ready states
func _on_ready_1_pressed():
	if(!p1Ready):
		p1Ready = true
		$MarginContainer/VBoxContainer/HBoxContainer/ready1.set_button_icon(selectedButtonIcon)
	else:
		p1Ready = false
		$MarginContainer/VBoxContainer/HBoxContainer/ready1.set_button_icon(buttonIcon)

#Toggles player2 between ready and not ready states
func _on_ready_2_pressed():	
	if(!p2Ready):
		p2Ready = true
		$MarginContainer/VBoxContainer/HBoxContainer/ready2.set_button_icon(selectedButtonIcon)
	else:
		p2Ready = false
		$MarginContainer/VBoxContainer/HBoxContainer/ready2.set_button_icon(buttonIcon)

#Changes the class type when the ready button is not selected
func _on_left_1_pressed():
	if(!p1Ready):
		if(p1Pointer == 0 || p1Pointer == -1):
			p1Pointer = 2
		else: 
			p1Pointer -= 1

func _on_right_1_pressed():
	if(!p1Ready):
		if(p1Pointer == 2 || p1Pointer == -1):
			p1Pointer = 0
		else: 
			p1Pointer += 1

func _on_left_2_pressed():
	if(!p2Ready):
		if(p2Pointer == 0 || p2Pointer == -1):
			p2Pointer = 2
		else: 
			p2Pointer -= 1

func _on_right_2_pressed():
	if(!p2Ready):
		if(p2Pointer == 2 || p2Pointer == -1):
			p2Pointer = 0
		else: 
			p2Pointer += 1
