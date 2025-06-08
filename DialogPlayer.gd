# Dialog Player

extends CanvasLayer

@export_file("*json") var scene_text_file: String

var scene_text = {}
var selected_text = []
var in_progress = false

@onready var background = $Background
@onready var text_label = $TextLabel
@onready var name_label = $NameLabel

func _ready():
	background.visible = false
	scene_text = load_scene_text()
	SignalBus.display_dialog.connect(on_display_dialog)

	func load_scene_text():
	if FileAccess.file_exists(scene_text_file):
		var file = FileAccess.open(scene_text_file, FileAccess.READ)
		return JSON.parse_string(file.get_as_text())
	return {}

		
func show_text():
	text_label.text = selected_text.pop_front()
	
func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()
		
func finish():
	text_label.text = ""
	background.visible = false
	in_progress = false
	get_tree()
	
		
func on_display_dialog(text_key):
	if in_progress:
		next_line()
	else:
		get_tree().paused = true
		background.visible = true
		in_progress = true
		selected_text = scene_text[text_key].duplicate()
		show_text()

		
