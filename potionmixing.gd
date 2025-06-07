extends Control

func _ready():
	pass

func _on_mixer_ingredient_dropped(ingredient_data: Variant) -> void:
	$ResultLabel.text = "Added: %s" % ingredient_data.name

func _on_mixer_mixing_successful(ingredient_data: Variant) -> void:
	$ResultLabel.text = "Successful Potion!"


func _on_mixer_mixing_unsuccessful(ingredient_data: Variant) -> void:
	$ResultLabel.text = "Unsuccessful Potion!"
