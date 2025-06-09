extends Control

signal ingredient_to_null_to_slot()
signal spellcast()

@export var spell: SpellData
@onready var ingredient_drop: AudioStreamPlayer = $ingredient_drop
@onready var intensity_1: AudioStreamPlayer = $intensity_1

func _ready():
	intensity_1.play()

func _on_mixer_ingredient_dropped(ingredient_data: Variant) -> void:
	$ResultLabel.text = "Added: %s, %s" % [ingredient_data.name, ingredient_data.type]
	if ingredient_data.sound_effect is AudioStream:
		ingredient_drop.stream = ingredient_data.sound_effect
	ingredient_drop.play()

func _on_mixer_ingredient_to_null() -> void:
	var invisible_ingredients = get_tree().get_nodes_in_group("invisible_ingredients")
	for node in invisible_ingredients:
		node.hide()

func _on_stirring_mixleft_pressed() -> void:
	$MixBar.value += 0.1
	if $MixBar.value == spell.mix_req and $PoundBar.value == spell.pound_req:
		$stirring.visible = false
		$MixBar.visible = false
		$PoundBar.visible = false
		$servebutton.disabled = false

func _on_stirring_mixright_pressed() -> void:
	$MixBar.value -= 0.1
	if $MixBar.value == spell.mix_req and $PoundBar.value == spell.pound_req:
		$stirring.visible = false
		$MixBar.visible = false
		$PoundBar.visible = false
		$servebutton.disabled = false

func _on_stirring_mixup_pressed() -> void:
	$PoundBar.value += 0.1
	if $MixBar.value == spell.mix_req and $PoundBar.value == spell.pound_req:
		$stirring.visible = false
		$MixBar.visible = false
		$PoundBar.visible = false
		$servebutton.disabled = false
