extends Node2D

@onready var themed_timer: Node2D = $ThemedTimer

var garlic_collected: int = 0
var timer_end: bool = false
var completed: bool = false


func _ready() -> void:
	await themed_timer.Timer(10.0)
	timer_end = true


func _process(_delta: float) -> void:
	if completed:
		return

	if garlic_collected >= 3:
		completed = true
		if Global.minigames_done >= 3:
			get_tree().change_scene_to_file("res://Scenes/title_scenes.tscn")
		else:
			get_tree().change_scene_to_file("res://level_scene.tscn")
		return

	if timer_end:
		completed = true
		Global.minigames_done = max(0, Global.minigames_done - 1)
		Global.lives -= 1
		get_tree().change_scene_to_file("res://level_scene.tscn")


func garlic_collect() -> void:
	garlic_collected += 1


func _on_coin_collected() -> void:
	garlic_collect()
