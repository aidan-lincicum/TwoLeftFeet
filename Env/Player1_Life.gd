extends Control

var heart_size = 80

func _on_player_life_changed(hearts):
	$TextureRect.rect_size.x = hearts * heart_size
