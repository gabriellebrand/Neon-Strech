extends Control

@onready var score_label: Label = $ScoreLabel
@onready var new_high_score_label: Label = $NewHighScoreLabel

func update_score_label(score):
    score_label.text = "Score: %08d" % score

#func update_life_icons(lives):
    
func flash_new_high_score_label():
    new_high_score_label.flash()
