extends CharacterBody2D

const SPEED = 400.0
const BULLET_COOLDOWN = 0.3  # seconds between shots

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var bullet_spawn: Marker2D = $BulletSpawn  # where bullets appear
@onready var cooldown_timer: Timer = $CooldownTimer

var bullet_scene = preload("res://bullet.tscn")  # adjust path if yours differs

func _ready():
	cooldown_timer.wait_time = BULLET_COOLDOWN
	cooldown_timer.one_shot = true

func _physics_process(_delta: float) -> void:
	# Movement
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED
	velocity.y = 0.0
	move_and_slide()

	# Flip sprite
	if direction > 0:
			sprite_2d.flip_h = false
	elif direction < 0:
		sprite_2d.flip_h = true

	  # Shoot
	if Input.is_action_just_pressed("ui_accept") and cooldown_timer.is_stopped():
		shoot()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = bullet_spawn.global_position
	get_tree().current_scene.add_child(bullet)
	cooldown_timer.start()
