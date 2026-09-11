extends Node2D


func _ready() -> void:
	Global.minigames_done = 0
	Global.lives = 5


func _process(_delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	Global.minigames_done = 0
	Global.lives = 5
	get_tree().change_scene_to_file("res://level_scene.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
