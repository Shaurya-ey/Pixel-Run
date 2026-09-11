extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_JUMPS = 2

var jumps_remaining = MAX_JUMPS


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jumps_remaining = MAX_JUMPS

	if Input.is_action_just_pressed("ui_accept") and jumps_remaining > 0:
		velocity.y = JUMP_VELOCITY
		jumps_remaining -= 1

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			sprite_2d.flip_h = false
		elif direction < 0:
			sprite_2d.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
