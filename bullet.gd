extends Area2D

var speed: float = 800.0


func _physics_process(delta: float) -> void:
	position.y -= speed * delta

	if position.y < -50.0:
		queue_free()
		return

	for enemy in get_tree().get_nodes_in_group("enemy"):
		if global_position.distance_to(enemy.global_position) < 60.0:
			enemy.queue_free()
			queue_free()
			break
