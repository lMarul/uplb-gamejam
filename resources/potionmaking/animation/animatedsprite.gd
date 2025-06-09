extends Node2D

@onready var mixing: AudioStreamPlayer = $mixing
@onready var beating: AudioStreamPlayer = $beating

func _on_stirring_mixleft_pressed() -> void:
	$AnimatedSprite2D.play("left_to_right")
	if not mixing.is_playing():
		mixing.play()

func _on_stirring_mixright_pressed() -> void:
	$AnimatedSprite2D.play_backwards("left_to_right")
	if not mixing.is_playing():
		mixing.play()

func _on_stirring_mixup_pressed() -> void:
	$AnimatedSprite2D.play("up_and_down")
	if not beating.is_playing():
		beating.play()

func _on_stirring_mixanim() -> void:
	visible = true


func _on_stirring_mixleft_released() -> void:
	$AnimatedSprite2D.stop()
	

func _on_stirring_mixright_released() -> void:
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.frame = 1
	
func _on_stirring_mixup_released() -> void:
	$AnimatedSprite2D.stop()
	beating.stop()
