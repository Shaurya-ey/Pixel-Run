extends Node2D

@onready var themed_timer: Node2D = $ThemedTimer
@onready var status_label: Label = $StatusLabel

var coins_collected: int = 0
var completed: bool = false
const TOTAL_COINS: int = 3


func _ready() -> void:
	if status_label:
		status_label.text = ""
	await themed_timer.start_timer(10.0)
	if not completed:
		_on_timeout()


func _on_coin_collected() -> void:
	if completed:
		return

	coins_collected += 1
	if coins_collected >= TOTAL_COINS:
		_on_cleared()


func _on_cleared() -> void:
	completed = true
	themed_timer.stop_timer()
	if status_label:
		status_label.text = "CLEARED!"
	await get_tree().create_timer(1.5).timeout

	if Global.minigames_done >= 3:
		get_tree().change_scene_to_file("res://Scenes/title_scenes.tscn")
	else:
		get_tree().change_scene_to_file("res://level_scene.tscn")


func _on_timeout() -> void:
	completed = true
	Global.lives -= 1
	Global.minigames_done = max(0, Global.minigames_done - 1)

	if Global.lives <= 0:
		if status_label:
			status_label.text = "GAME OVER!"
			status_label.set("theme_override_colors/font_color", Color(0.9, 0.1, 0.1, 1))
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://Scenes/title_scenes.tscn")
	else:
		if status_label:
			status_label.text = "TIME'S UP!"
			status_label.set("theme_override_colors/font_color", Color(0.9, 0.2, 0.2, 1))
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://level_scene.tscn")
