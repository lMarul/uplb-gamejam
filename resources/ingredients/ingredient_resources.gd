# ingredient_data.gd
extends Resource
class_name IngredientData

@export var name: String = "Unnamed Ingredient"
@export_enum("base", "booster", "stabilizer") var type: String = "base"
@export var properties: Dictionary = {}  # Example: {"heat": 10, "cool": 5}
@export_range(0.0, 1.0) var explosive_chance: float = 0.0
@export var icon: Texture
