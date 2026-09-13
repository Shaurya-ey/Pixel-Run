extends Node2D

@onready var timer_label = get_node_or_null("Timer")

var time = 10.0
var is_running = false

func _process(delta):
	if is_running and time > 0.0:
		time = max(0.0, time - delta)
		if time <= 0.0:
			is_running = false
			time = 0.0

	if timer_label:
		timer_label.text = "%.1f" % max(0.0, time)

func start_timer(start_time = 10.0):
	time = start_time
	is_running = true
	while time > 0.0 and is_running:
		await get_tree().process_frame
	is_running = false

func stop_timer():
	is_running = false
