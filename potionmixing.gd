extends Control

signal stirringready()
signal ingredient_to_null_to_slot()

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	pass

func _on_mixer_ingredient_dropped(ingredient_data: Variant) -> void:
	$ResultLabel.text = "Added: %s, %s" % [ingredient_data.name, ingredient_data.type]
	if ingredient_data.sound_effect is AudioStream:
		audio_stream_player.stream = ingredient_data.sound_effect
	audio_stream_player.play()

func _on_mixer_ingredient_to_null() -> void:
	emit_signal("ingredient_to_null_to_slot")

func _on_stirring_mixleft_pressed() -> void:
	$MixBar.value += 0.1

func _on_stirring_mixright_pressed() -> void:
	$MixBar.value -= 0.1

func _on_stirring_mixup_pressed() -> void:
	$PoundBar.value += 0.1
