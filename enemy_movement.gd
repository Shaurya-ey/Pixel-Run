extends Node2D

var move_speed = 120
var drop_amount = 40
var current_dir = 1
var edge_buffer = 40
var screen_w = 1152

func _physics_process(delta):
	var should_drop = false
	var min_x = 99999
	var max_x = -99999

	for e in get_children():
		if e is Area2D:
			var ex = e.global_position.x
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

	for e in get_children():
		if e is Area2D:
			e.position.x += current_dir * move_speed * delta

	if should_drop:
		for e in get_children():
			if e is Area2D:
				e.position.y += drop_amount

	for e in get_children():
		if e is Area2D and e.global_position.y >= 500:
			get_tree().call_group("game_manager", "_on_enemies_reached_bottom")
			break