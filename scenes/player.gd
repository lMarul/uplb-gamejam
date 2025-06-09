extends CharacterBody2D

const SPEED = 200
const JUMP_VELOCITY = -400.0

@onready var animated_idle = $AnimatedIdle
@onready var animated_walk = $AnimatedWalk

func _ready():
	animated_idle.visible = true
	animated_walk.visible = false

func _physics_process(delta: float) -> void:
	# Add gravity if not on the floor
	if not is_on_floor():
		velocity += get_gravity() * delta

	# WASD + Arrow key support
	var input_vector = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

	# X Movement
	if input_vector.x != 0.0:
		velocity.x = input_vector.x * SPEED

		# Flip sprites
		animated_idle.flip_h = input_vector.x < 0
		animated_walk.flip_h = input_vector.x < 0

		# Show walking animation
		animated_idle.visible = false
		animated_walk.visible = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

		# Show idle animation
		animated_idle.visible = true
		animated_walk.visible = false

	# Y Movement (optional — if your game supports top-down movement or gravity-based falling)
	# Remove/comment this if you're using side-scrolling only
	# velocity.y = input_vector.y * SPEED  # Uncomment if you want up/down movement

	move_and_slide()
