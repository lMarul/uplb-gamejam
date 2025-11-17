extends TextureRect

@onready var QTE := QuickTimeEvent.new()
@export var patientdata: SpellData

func _ready() -> void:
	add_child(QTE)
	
	QTE.duration = 2
	QTE.failed_input.connect(_qte_failed)
		
func _on_servebutton_spellcasting_time() -> void:
	QTE.start_qte()

func _qte_failed():
	print("FAILED")
