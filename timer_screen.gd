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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await Timer(2.0)

	if Global.minigames_done < 3:
		Global.minigames_done = Global.minigames_done + 1
		get_tree().change_scene_to_file("res://minigame_" + str(Global.minigames_done) + ".tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/title_scenes.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match Global.lives: # asks or checks if lives is equal to one of
#these values, cool hack. by the way this is a horrid way to illustrate the
#lives visually so later you can always find alternative code. Now, dw abt it.

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
		0:
			heart_container.hide() # just hides everything

	timer.text = "%.1f" % time # make the text reflect the value of the time variable nicely formatted
	level.text = "Level " + str(Global.minigames_done) # this tells you what minigame you're on using concatenation (google the word yo)

func Timer(start_time: float): # making a new function for timer countdown!
	# we want the timer to go down, and when it reaches 0 it transitions
	# to the next scene!

	time = start_time # make the timer, which is reflected through the timer text, start at your desired number

	while time > 0.0: # run if timer hasnt reached 0
		await wait(0.1) # asks script to wait on this function. the 'wait' name for the function does nothing here, as await is just telling the script to wait for the function to complete before progressing
		time -= 0.1 # remove 0.1
		# progressively get the value smaller and smaller

	#when timer reaches 0
	return

func wait(seconds: float) -> void: # write this simple function out for wait!
	await get_tree().create_timer(seconds).timeout # makes u wait, dw abt this being complex '''
