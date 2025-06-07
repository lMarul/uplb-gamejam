extends Control

signal ingredient_dropped(ingredient_data)

var added_ingredients: Array = []

func can_drop_data(_pos, data):
	print("👀 Dragged data received")
	return data is Resource

func drop_data(_pos, data):
	added_ingredients.append(data)
	emit_signal("ingredient_dropped", data)
	print("✅")

	if added_ingredients.size() >= 3:
		process_potion()
		added_ingredients.clear()

func process_potion():
	var types = {
		"base": false,
		"booster": false,
		"stabilizer": false,
	}

	for ingredient in added_ingredients:
		if ingredient.type in types:
			types[ingredient.type] = true

	if types["base"] and types["booster"] and types["stabilizer"]:
		print("🎉 Potion crafted successfully!")
	else:
		print("⚠️ Invalid mix: Missing ingredient types")
