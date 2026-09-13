extends Node2D

@onready var themed_timer = $ThemedTimer
@onready var status_label = $StatusLabel

var completed = false
var total_enemies = 0
var enemies_alive = 0

func _ready():
	add_to_group("game_manager")
	status_label.text = ""

	# count how many enemies we have at the start
	var enemy_container = $Enemies
	total_enemies = enemy_container.get_child_count()
	enemies_alive = total_enemies

	# when one dies we count it down
	for enemy in enemy_container.get_children():
		enemy.tree_exited.connect(_on_enemy_destroyed)

	await themed_timer.start_timer(15)
	if not completed:
		_on_timeout()

func _on_enemy_destroyed():
	if completed:
		return
	enemies_alive -= 1
	if enemies_alive <= 0:
		_on_cleared()

func _on_enemies_reached_bottom():
	# they got past you, counts as a loss like running out of time
	if not completed:
		_on_timeout()

func _on_cleared():
	completed = true
	themed_timer.stop_timer()
	status_label.text = "CLEARED!"
	await get_tree().create_timer(1.5).timeout
	if Global.minigames_done >= 3:
		get_tree().change_scene_to_file("res://Scenes/title_scenes.tscn")
	else:
		get_tree().change_scene_to_file("res://level_scene.tscn")

func _on_timeout():
	completed = true
	Global.lives -= 1
	Global.minigames_done = max(0, Global.minigames_done - 1)
	if Global.lives <= 0:
		status_label.text = "GAME OVER!"
		status_label.set("theme_override_colors/font_color", Color(0.9, 0.1, 0.1))
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://Scenes/title_scenes.tscn")
	else:
		status_label.text = "TIME'S UP!"
		status_label.set("theme_override_colors/font_color", Color(0.9, 0.2, 0.2))
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://level_scene.tscn")
