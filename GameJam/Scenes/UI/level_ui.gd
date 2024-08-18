extends Control

@onready var score_label: Label = $ScoreLabel

func update_score_label(score):
    score_label.text = "Score: %08d" % score
