extends Button

signal start_mix()
signal stop_drop()
var buttonflag = null



func _pressed():
	var mixbar = get_parent().get_node("MixBar")
	var poundbar = get_parent().get_node("PoundBar")
	
	mixbar.visible = true
	poundbar.visible = true
	emit_signal("stop_drop")
	emit_signal("start_mix", buttonflag)

func _on_mixer_mixing_successful(flag: Variant) -> void:
	disabled = false
	buttonflag = flag
	
func _on_mixer_mixing_unsuccessful(flag: Variant) -> void:
	disabled = false
	buttonflag = flag
