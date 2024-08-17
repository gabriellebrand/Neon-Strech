extends Control

@onready var high_score_label: Label = $VBoxContainer/HighScoreLabel

func _ready() -> void:
  set_high_score(15)

func _on_play_button_pressed() -> void:
  get_tree().change_scene_to_file("res://Scenes/Main.tscn")
  
func set_high_score(score):
  high_score_label.text = "High Score: " + str(score)
