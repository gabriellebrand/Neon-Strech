extends Node

var score = 0
@onready var score_label = $"../Labels/ScoreLabel"
@onready var player = %Player

func _ready():
	print("Hello Game Manager")
	
func _on_hud_start_game():
	print("Startttt")
	player.active = true
	player.visible = true
	
func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins. Die."

#func _input(event):
	#if event.is_action_pressed("ChangeColor"):
	#
	#if event.is_action_released("ChangeColor"):
