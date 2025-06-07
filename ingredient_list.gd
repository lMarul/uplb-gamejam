extends Control

signal ingredient_play()

func _on_mixercontrol_ingredient_to_null_to_slot() -> void:
	emit_signal("ingredient_play")
