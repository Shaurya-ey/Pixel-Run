extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var bullet_spawn: Marker2D = $BulletSpawn
@onready var cooldown_timer: Timer = $CooldownTimer

const SPEED: float = 400.0
const SHOOT_COOLDOWN: float = 0.3

var bullet_scene: PackedScene = preload("res://bullet.tscn")


func _ready() -> void:
	cooldown_timer.wait_time = SHOOT_COOLDOWN
	cooldown_timer.one_shot = true


func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED
	move_and_slide()

	if direction > 0:
		sprite_2d.flip_h = false
	elif direction < 0:
		sprite_2d.flip_h = true

	if Input.is_action_just_pressed("ui_accept") and cooldown_timer.is_stopped():
		shoot()


func shoot() -> void:
	var bullet := bullet_scene.instantiate()
	bullet.global_position = bullet_spawn.global_position
	get_tree().current_scene.add_child(bullet)
	cooldown_timer.start()
