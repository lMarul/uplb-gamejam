extends Node

func _ready():
	connect_button("Bab's House", _on_babs_house_pressed)
	connect_button("Plaza", _on_plaza_pressed)
	connect_button("Worship Area", _on_worship_area_pressed)
	connect_button("Healing Area", _on_healing_area_pressed)

func connect_button(name: String, handler: Callable):
	var button = get_node_or_null(name)
	if button:
		button.pressed.connect(handler)
	else:
		print("⚠️ Could not find button node: ", name)

func _on_babs_house_pressed():
	get_tree().change_scene_to_file("res://IMPORTANT Map and Areas/BabsHouse.tscn")

func _on_plaza_pressed():
	get_tree().change_scene_to_file("res://IMPORTANT Map and Areas/Plaza.tscn")

func _on_worship_area_pressed():
	get_tree().change_scene_to_file("res://IMPORTANT Map and Areas/WorshipArea.tscn")

func _on_healing_area_pressed():
	get_tree().change_scene_to_file("res://IMPORTANT Map and Areas/HealingArea.tscn")
