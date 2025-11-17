extends Button

signal spellcasting_time()

func _pressed():
	emit_signal("spellcasting_time")
