extends TextureRect
var added_ingredients: Array = []

signal ingredient_dropped(ingredient_data)
signal ingredient_to_null()
signal mixing_successful()
signal mixing_unsuccessful()

func _can_drop_data(_pos, data):
	return data is IngredientData

func _drop_data(_pos, data):	
	added_ingredients.append(data)
	emit_signal("ingredient_dropped", data)
	emit_signal("ingredient_to_null")
	
	if added_ingredients.size() >= 3:
		process_potion(data)
		added_ingredients.clear()

func process_potion(data):
	var types = {
		"base": false,
		"booster": false,
		"stabilizer": false,
	}

	for ingredient in added_ingredients:
		if ingredient.type in types:
			types[ingredient.type] = true

	if types["base"] and types["booster"] and types["stabilizer"]:
		emit_signal("mixing_successful")
	else:
		emit_signal("mixing_unsuccessful")


func _on_stirring_mixleft_pressed() -> void:
	$ProgressBar.value += 0.1

func _on_stirring_mixright_pressed() -> void:
	$ProgressBar.value -= 0.1

func _on_stirring_mixup_pressed() -> void:
	$ProgressBar.value += 0.1
