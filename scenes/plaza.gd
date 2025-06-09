extends Node

func _ready():
	var back_button = get_node_or_null("Control/BackButton")
	if back_button:
		back_button.pressed.connect(_on_back_button_pressed)
	else:
		print("⚠️ Could not find BackButton!")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Map.tscn")
