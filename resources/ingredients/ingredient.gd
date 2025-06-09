# ingredient.gd
extends Control

@export var ingredient_data: IngredientData

func _get_drag_data(_pos: Vector2) -> Variant:
	var preview = duplicate()
	var c = Control.new()
	c.add_child(preview)
	preview.position = Vector2.ZERO - _pos
	set_drag_preview(c)
	add_to_group("invisible_ingredients")
	return ingredient_data
