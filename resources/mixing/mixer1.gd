extends TextureRect
var added_ingredients: Array = []

signal ingredient_dropped(ingredient_data)
signal mixing_successful(ingredient_data)
signal mixing_unsuccessful(ingredient_data)

func _can_drop_data(_pos, data):
	return data is IngredientData

func _drop_data(_pos, data):
	added_ingredients.append(data)
	emit_signal("ingredient_dropped", data)
	
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
		emit_signal("mixing_successful", data)
	else:
		emit_signal("mixing_unsuccessful", data)
