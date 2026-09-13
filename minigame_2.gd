extends Node2D

@onready var themed_timer: Node2D = $ThemedTimer
@onready var status_label: Label = $StatusLabel

var completed: bool = false
var total_enemies: int = 0
var enemies_alive: int = 0


func _ready() -> void:
	status_label.text = ""

	# Count enemies at start
	var enemy_container = $Enemies
	total_enemies = enemy_container.get_child_count()
	enemies_alive = total_enemies

	# Connect enemy signals
	for enemy in enemy_container.get_children():
		enemy.tree_exited.connect(_on_enemy_destroyed)

	# Start the countdown
	await themed_timer.start_timer(15.0)
	if not completed:
		_on_timeout()


func _on_enemy_destroyed() -> void:
	if completed:
		return
	enemies_alive -= 1
	if enemies_alive <= 0:
		_on_cleared()


func _on_cleared() -> void:
	completed = true
	themed_timer.stop_timer()
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
		status_label.text = "GAME OVER!"
		status_label.set("theme_override_colors/font_color", Color(0.9, 0.1, 0.1, 1))
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://Scenes/title_scenes.tscn")
	else:
		status_label.text = "TIME'S UP!"
		status_label.set("theme_override_colors/font_color", Color(0.9, 0.2, 0.2, 1))
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://level_scene.tscn")
