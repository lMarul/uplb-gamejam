extends Button

signal start_mix(mix_flag)

func _on_mixer_mixing_successful() -> void:
	disabled = false
	var mix_flag = true
	emit_signal("start_mix", mix_flag)

func _on_mixer_mixing_unsuccessful() -> void:
	disabled = false
	var mix_flag = false
	emit_signal("start_mix", mix_flag)
