extends CharacterBody2D

var speed = 400
var shoot_cooldown = 0.3

@onready var sprite_2d = $Sprite2D
@onready var bullet_spawn = $BulletSpawn
@onready var cooldown_timer = $CooldownTimer

var bullet_scene = preload("res://bullet.tscn")

func _ready():
	cooldown_timer.wait_time = shoot_cooldown
	cooldown_timer.one_shot = true

func _physics_process(delta):
	# move left and right
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed
	move_and_slide()

	# flip the sprite so it faces where we're going
	if direction > 0:
		sprite_2d.flip_h = false
	elif direction < 0:
		sprite_2d.flip_h = true

	# shoot if we press the button and the cooldown is over
	if Input.is_action_just_pressed("ui_accept") and cooldown_timer.is_stopped():
		shoot()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = bullet_spawn.global_position
	get_tree().current_scene.add_child(bullet)
	cooldown_timer.start()
