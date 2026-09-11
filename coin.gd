extends Node2D

@onready var player: CharacterBody2D = $"../Player"
@onready var self_area: Area2D = $Area2D
@onready var player_area: Area2D = $"../Player/Area2D"

signal coin_collected
signal garlic_collected


func _process(_delta: float) -> void:
	if player_area and self_area and player_area.overlaps_area(self_area):
		if visible:
			emit_signal("coin_collected")
			emit_signal("garlic_collected")
			hide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area == player_area and visible:
		emit_signal("coin_collected")
		emit_signal("garlic_collected")
		hide()
