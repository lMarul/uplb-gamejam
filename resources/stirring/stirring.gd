extends Control

signal mixup_pressed()
signal mixright_pressed()
signal mixleft_pressed()
var flag = null

func _ready():
	$MixUp.visible = false
	$MixRight.visible = false
	$MixLeft.visible = false
	set_process(false)

func _process(delta):
	if Input.is_action_pressed("mix_up"):
		emit_signal("mixup_pressed")
		$MixUp.modulate = Color(0.6, 0.6, 0.6)
	elif Input.is_action_just_released("mix_up"):
		emit_signal("mixup_released")
		$MixUp.modulate = Color(1, 1, 1)
		
	if Input.is_action_pressed("mix_right"):
		emit_signal("mixright_pressed")
		$MixRight.modulate = Color(0.6, 0.6, 0.6)
	elif Input.is_action_just_released("mix_right"):
		emit_signal("mixright_released")
		$MixRight.modulate = Color(1, 1, 1)

	if Input.is_action_pressed("mix_left"):
		emit_signal("mixleft_pressed")
		$MixLeft.modulate = Color(0.6, 0.6, 0.6)
	elif Input.is_action_just_released("mix_left"):
		emit_signal("mixleft_released")
		$MixLeft.modulate = Color(1, 1, 1)


func _on_mixbutton_start_mix(mix_flag: Variant) -> void:
	flag = mix_flag
	$MixUp.visible = true
	$MixRight.visible = true
	$MixLeft.visible = true
	set_process(true)
