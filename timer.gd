extends Node2D

@onready var timer: RichTextLabel = get_node_or_null("Timer") if get_node_or_null("Timer") else get_node_or_null("timer")

var time: float = 10.0
var is_running: bool = false


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if is_running and time > 0.0:
		time = max(0.0, time - delta)
		if time <= 0.0:
			is_running = false
			time = 0.0

	if timer:
		timer.text = "%.1f" % max(0.0, time)


func Timer(start_time: float) -> void:
	time = start_time
	is_running = true
	while time > 0.0 and is_running:
		await get_tree().process_frame
	is_running = false


func stop() -> void:
	is_running = false


func _Timer(start_time: float) -> void:
	await Timer(start_time)
