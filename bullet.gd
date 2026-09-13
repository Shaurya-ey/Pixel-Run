extends Area2D

var speed = 800

func _ready():
	area_entered.connect(_on_area_entered)

func _physics_process(delta):
	position.y -= speed * delta
	# clean up once it flies off screen
	if position.y < -50:
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		area.queue_free()
		queue_free()