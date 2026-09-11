extends Node2D

signal coin_collected

@onready var area_2d: Area2D = $Area2D
@onready var player_area: Area2D = $"../Player/Area2D"

var is_collected: bool = false


func _ready() -> void:
	area_2d.area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if is_collected:
		return

	if area == player_area:
		is_collected = true
		coin_collected.emit()
		hide()
		area_2d.set_deferred("monitoring", false)
		area_2d.set_deferred("monitorable", false)
