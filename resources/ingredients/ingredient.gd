# ingredient.gd
extends TextureRect

@export var ingredient_data: IngredientData

func _get_drag_data(_at_position: Vector2) -> Variant:
	var preview = TextureRect.new()
	preview.texture = ingredient_data.icon
	set_drag_preview(preview)
	return ingredient_data

func change_text():
	$Label.text = name
