extends Control

var classArray = ["Balanced", "Sniper", "Assassin", "Heavy"] #Holds the names of player classes
var p1Pointer = -1 # Index of the selected player class for player 1
var p2Pointer = -1 # Index of the selected player class for player 2

#Switches scene to env which holds the actual game
func _on_play_button_pressed():
	if(p1Pointer != -1 && p2Pointer != -1):
		var root_node = get_tree().root
		var scene_node = root_node.get_node("Main Menu")
		scene_node.queue_free()

		var new_scene = load("res://Env/env.tscn").instantiate()
		new_scene.set_player_classes(classArray[p1Pointer], classArray[p2Pointer])
		root_node.add_child(new_scene)

# Quits the game
func _on_quit_button_pressed():
	get_tree().quit()

#Code to change player class
func _on_left_p_1_pressed():
	if(p1Pointer == 0 || p1Pointer == -1):
		p1Pointer = 3
	else: 
		p1Pointer -= 1
	
	$MarginContainer/VBoxContainer/HBoxContainer3/p1Class.clear()
	var p1String = "[center]" + classArray[p1Pointer] + "[/center]" 
	$MarginContainer/VBoxContainer/HBoxContainer3/p1Class.append_text(p1String)

func _on_right_p_1_pressed():
	if(p1Pointer == 3 || p1Pointer == -1):
		p1Pointer = 0
	else: 
		p1Pointer += 1
	
	$MarginContainer/VBoxContainer/HBoxContainer3/p1Class.clear()
	var p1String = "[center]" + classArray[p1Pointer] + "[/center]" 
	$MarginContainer/VBoxContainer/HBoxContainer3/p1Class.append_text(p1String)


func _on_left_p_2_pressed():
	if(p2Pointer == 0 || p2Pointer == -1):
		p2Pointer = 3
	else: 
		p2Pointer -= 1
	
	$MarginContainer/VBoxContainer/HBoxContainer3/p2Class.clear()
	var p2String = "[center]" + classArray[p2Pointer] + "[/center]" 
	$MarginContainer/VBoxContainer/HBoxContainer3/p2Class.append_text(p2String)

func _on_right_p_2_pressed():
	if(p2Pointer == 3 || p2Pointer == -1):
		p2Pointer = 0
	else: 
		p2Pointer += 1
	
	$MarginContainer/VBoxContainer/HBoxContainer3/p2Class.clear()
	var p2String = "[center]" + classArray[p2Pointer] + "[/center]" 
	$MarginContainer/VBoxContainer/HBoxContainer3/p2Class.append_text(p2String)
