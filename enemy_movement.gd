extends Node2D

var move_speed: float = 120.0
var drop_amount: float = 40.0
var current_dir: int = 1
var edge_buffer: float = 40.0
var screen_w: float = 1152.0


func _physics_process(delta: float) -> void:
	var should_drop := false
	var min_x := 99999.0
	var max_x := -99999.0

	for enemy in get_children():
		if enemy is Area2D:
			var ex: float = enemy.global_position.x
			if ex < min_x:
				min_x = ex
			if ex > max_x:
				max_x = ex

	if current_dir == 1 and max_x >= screen_w - edge_buffer:
		current_dir = -1
		should_drop = true
	elif current_dir == -1 and min_x <= edge_buffer:
		current_dir = 1
		should_drop = true

	for enemy in get_children():
		if enemy is Area2D:
			enemy.position.x += current_dir * move_speed * delta

	if should_drop:
		for enemy in get_children():
			if enemy is Area2D:
				enemy.position.y += drop_amount

	for enemy in get_children():
		if enemy is Area2D and enemy.global_position.y >= 500.0:
			get_tree().call_group("game_manager", "_on_enemies_reached_bottom")
			break
