extends Node2D

@onready var player: CharacterBody2D = $"../Player"
@onready var self_area: Area2D = $Area2D
@onready var player_area: Area2D = $"../Player/Area2D"

signal coin_collected

var is_collected: bool = false


func _process(_delta: float) -> void:
	if is_collected:
		return
	if player_area and self_area and player_area.overlaps_area(self_area):
		collect()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if is_collected:
		return
	if area == player_area:
		collect()


func collect() -> void:
	if is_collected:
		return
	is_collected = true
	emit_signal("coin_collected")
	hide()
