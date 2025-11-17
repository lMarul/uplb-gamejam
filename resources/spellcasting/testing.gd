extends Node2D

@export var spelling_data: SpellData

func _on_servebutton_spellcasting_time() -> void:
		var panel_position = self.position
		QTE.start_qte(spelling_data.spelling, spelling_data.icon, panel_position)
