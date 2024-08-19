extends Control

@onready var high_score_label: Label = $VBoxContainer/HighScoreLabel

func _on_play_button_pressed():
    GameManager.start_run()

func update_high_score_label(score):
    high_score_label.text = "Highest Score: %8d" % score
