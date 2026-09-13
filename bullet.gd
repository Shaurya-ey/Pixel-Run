extends Area2D

const SPEED = 800.0

func _ready():
	area_entered.connect(_on_area_entered)

func _physics_process(delta: float) -> void:
		position.y -= SPEED * delta  # fly upward
		if position.y < -50:  # cleanup when off-screen
			queue_free()

func _on_area_entered(area: Area2D):
		if area.is_in_group("enemy"):
			area.get_parent().queue_free()  # destroy enemy
			queue_free()  # destroy bullet
