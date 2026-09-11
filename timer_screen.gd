extends Node2D

@onready var heart_container: HBoxContainer = $TextureRect/HeartContainer
@onready var heart: TextureRect = $TextureRect/HeartContainer/Heart
@onready var heart_2: TextureRect = $TextureRect/HeartContainer/Heart2
@onready var heart_3: TextureRect = $TextureRect/HeartContainer/Heart3
@onready var heart_4: TextureRect = $TextureRect/HeartContainer/Heart4
@onready var heart_5: TextureRect = $TextureRect/HeartContainer/Heart5
@onready var level: RichTextLabel = $Level
@onready var timer: RichTextLabel = $Timer

var time: float = 2.0


func _ready() -> void:
	if Global.lives <= 0:
		level.text = "GAME OVER"
		timer.text = "0.0"
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://Scenes/title_scenes.tscn")
		return

	await Timer(2.0)

	var next_minigame: int = Global.minigames_done + 1
	var next_scene_path: String = "res://minigame_" + str(next_minigame) + ".tscn"

	if Global.minigames_done < 3 and ResourceLoader.exists(next_scene_path):
		Global.minigames_done = next_minigame
		get_tree().change_scene_to_file(next_scene_path)
	else:
		# If next minigame doesn't exist yet or all minigames are completed, return to Main Menu
		get_tree().change_scene_to_file("res://Scenes/title_scenes.tscn")


func _process(_delta: float) -> void:
	match Global.lives:
		5:
			pass
		4:
			heart.hide()
		3:
			heart.hide()
			heart_2.hide()
		2:
			heart.hide()
			heart_2.hide()
			heart_3.hide()
		1:
			heart.hide()
			heart_2.hide()
			heart_3.hide()
			heart_4.hide()
		_:
			heart_container.hide()

	timer.text = "%.1f" % max(0.0, time)
	level.text = "Level " + str(Global.minigames_done + 1)


func Timer(start_time: float) -> void:
	time = start_time
	while time > 0.05:
		await wait(0.1)
		time = max(0.0, time - 0.1)
	time = 0.0


func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
