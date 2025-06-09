extends Node

enum QTE_STATES {START, RUNNING, FAILED, SUCCESS, STOPPED}
var QTE_STATUS: QTE_STATES = QTE_STATES.STOPPED

var QTE_LAYER: PackedScene
var QTE_PANEL: Panel
var QTE_TIMER_LABEL: Label
var QTE_ACTION_TIMER_LABEL: Label
var QTE_LABEL: Label
var QTE_PLAYER_LABEL: Label
var QTE_FEEDBACK: Label
var QTE_IMAGE: TextureRect

var POSSIBLE_ACTIONS = []
var CURRENT_QTE: Array = []
var PLAYER_QTE: Array = []

var QTE_SIZE: int = 1
var QTE_MAX_SIZE: int = 9
var QTE_INCREMENTER: int = 0

var QTE_TIME_LIMIT: float = 4
var QTE_ACTION_TIME_LIMIT: float = 2

var QTE_TIMER: float = 4
var QTE_ACTION_TIMER: float = 2

func _ready() -> void:
	QTE_LAYER = load("res://resources/spellcasting/QTESpellcasting.tscn")

func _unhandled_input(event: InputEvent) -> void:
	print(QTE_STATUS)
	if QTE_STATUS == QTE_STATES.RUNNING:
		print(PLAYER_QTE)
		print(CURRENT_QTE)
		if PLAYER_QTE == CURRENT_QTE:
			print("Success!")
			QTE_STATUS = QTE_STATES.SUCCESS
			QTE_INCREMENTER += 1
			if QTE_INCREMENTER > QTE_MAX_SIZE:
				QTE_INCREMENTER = QTE_MAX_SIZE
			QTE_SIZE = QTE_SIZE + floor(QTE_INCREMENTER / 2)
			if QTE_LAYER:
				if QTE_FEEDBACK:
					QTE_FEEDBACK.text = "SUCCESS!"
				await get_tree().create_timer(1).timeout
				var instance = get_tree().root.find_child("QTE_LAYER", true, false)
				if instance:
					instance.queue_free()	
				stop_qte()
				
	if PLAYER_QTE.size() < CURRENT_QTE.size():
		var expected_key = CURRENT_QTE[PLAYER_QTE.size()]
		if Input.is_action_just_pressed(expected_key):
			PLAYER_QTE.push_back(expected_key)
			print(PLAYER_QTE)

			if QTE_PLAYER_LABEL:
				QTE_PLAYER_LABEL.text = str(PLAYER_QTE)

			QTE_ACTION_TIMER = QTE_ACTION_TIME_LIMIT

			# Optional: Check if full sequence was entered
			if PLAYER_QTE == CURRENT_QTE:
				print("Success!")
				QTE_STATUS = QTE_STATES.SUCCESS
				QTE_INCREMENTER += 1
				if QTE_INCREMENTER > QTE_MAX_SIZE:
					QTE_INCREMENTER = QTE_MAX_SIZE
				QTE_SIZE += floor(QTE_INCREMENTER / 2)
				
				if QTE_FEEDBACK:
					QTE_FEEDBACK.text = "SUCCESS!"
				
				await get_tree().create_timer(1).timeout

				var instance = get_tree().root.find_child("QTE_LAYER", true, false)
				if instance:
					instance.queue_free()	
				stop_qte()
		else:
			# Optional: Handle wrong key press here
			print("Wrong input!")


func _process(delta: float) -> void:
	if QTE_STATUS == QTE_STATES.RUNNING:
		QTE_TIMER -= delta
		QTE_ACTION_TIMER -= delta
		if QTE_IMAGE:
			var safe_timer = max(QTE_ACTION_TIMER, 0.01)
			var time := Time.get_ticks_msec() / 1000.0
			var frequency = 1.0 / safe_timer * 1.0
			var flash := 0.5 + 0.5 * sin(time * frequency * TAU)
			QTE_IMAGE.modulate = Color(flash, flash, flash)
		if QTE_TIMER_LABEL:
			QTE_TIMER_LABEL.text = "QTE TIMER: " + str(floor(QTE_TIMER*100)/100)
		if QTE_ACTION_TIMER_LABEL:
			QTE_ACTION_TIMER_LABEL.text = "QTE NEXT ACTION: " + str(floor(QTE_ACTION_TIMER*100)/100)
		if PLAYER_QTE != CURRENT_QTE && (QTE_TIMER <= 0 || QTE_ACTION_TIMER <= 0):
			print("FAILED")
			QTE_STATUS = QTE_STATES.FAILED
			QTE_FEEDBACK.text = "FAILED"
			stop_qte()

func stop_qte() -> void:
	await get_tree().create_timer(2).timeout
	QTE_STATUS = QTE_STATES.STOPPED
	var instance = get_tree().root.find_child("QTE_LAYER", true, false)
	if instance:
		QTE_IMAGE.modulate = Color(1, 1, 1)
		instance.queue_free()
		
func start_qte(array_data, image, panel_position) -> void:
	POSSIBLE_ACTIONS = array_data
	if QTE_STATUS != QTE_STATES.STOPPED:
		return
	if QTE_LAYER:
		var instance = QTE_LAYER.instantiate()
		QTE_PANEL = instance.find_child("Panel", true, false)
		QTE_TIMER_LABEL = instance.find_child("QTE_TIMER", true, false)
		QTE_ACTION_TIMER_LABEL = instance.find_child("QTE_ACTION_TIMER", true, false)
		QTE_PLAYER_LABEL = instance.find_child("QTE_PLAYER", true, false)
		QTE_LABEL = instance.find_child("QTE", true, false)
		QTE_FEEDBACK = instance.find_child("QTE_FEEDBACK", true, false)
		QTE_IMAGE = instance.find_child("QTE_IMAGE", true, false)
		QTE_IMAGE.texture = image
		QTE_PANEL.position = panel_position
		get_tree().root.add_child(instance)
	
	QTE_TIMER = QTE_TIME_LIMIT
	QTE_ACTION_TIMER = QTE_ACTION_TIME_LIMIT
	CURRENT_QTE = []
	PLAYER_QTE = []
	for length in QTE_SIZE:
		CURRENT_QTE.push_back(POSSIBLE_ACTIONS.pick_random())
	
	if QTE_LABEL:
		var label_text = str(CURRENT_QTE)
		QTE_LABEL.text = label_text.substr(2, 1)
	if QTE_FEEDBACK:
		QTE_FEEDBACK.text = "GET READY"
	
	await get_tree().create_timer(1).timeout
	
	if QTE_FEEDBACK:
		QTE_FEEDBACK.text = "GO"
	
	await get_tree().create_timer(1).timeout
	
	QTE_STATUS = QTE_STATES.RUNNING
