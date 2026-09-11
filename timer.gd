extends Node2D

@onready var timer_label: RichTextLabel = get_node_or_null("Timer")

var time: float = 10.0
var is_running: bool = false


func _process(delta: float) -> void:
	if is_running and time > 0.0:
		time = max(0.0, time - delta)
		if time <= 0.0:
			is_running = false
			time = 0.0

	if timer_label:
		timer_label.text = "%.1f" % max(0.0, time)


func start_timer(start_time: float = 10.0) -> void:
	time = start_time
	is_running = true
	while time > 0.0 and is_running:
		await get_tree().process_frame
	is_running = false


func stop_timer() -> void:
	is_running = false


# Aliases for backward compatibility
func Timer(start_time: float) -> void:
	await start_timer(start_time)


func stop() -> void:
	stop_timer()
