extends Node2D

@onready var timer: RichTextLabel = get_node_or_null("Timer") if get_node_or_null("Timer") else get_node_or_null("timer")

var time: float = 10.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if timer:
		timer.text = "%.1f" % max(0.0, time)


func Timer(start_time: float) -> void:
	time = start_time
	while time > 0.0:
		await wait(0.1)
		time = max(0.0, time - 0.1)


func _Timer(start_time: float) -> void:
	await Timer(start_time)


func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
