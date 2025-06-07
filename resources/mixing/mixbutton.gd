extends Button

signal start_mix()
var flag = null

func _pressed():
	emit_signal("start_mix", flag)

func _on_mixer_mixing_successful(flag: Variant) -> void:
	disabled = false
	flag = true
	
func _on_mixer_mixing_unsuccessful(flag: Variant) -> void:
	disabled = false
	flag = false
