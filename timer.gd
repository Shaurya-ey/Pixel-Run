extends Node2D
@onready var timer: RichTextLabel = $timer

var time: float 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	timer.text = str(snapped(time, 0.10))
	
func _Timer(start_time: float):

	time = start_time
	while time > 0.0:
		await wait(0.10)
		time = time - 0.10
	return
	
func wait(seconds: float) -> void: 
	await get_tree().create_timer(seconds).timeout
