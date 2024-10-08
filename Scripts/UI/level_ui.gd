extends Control

@onready var score_label: Label = $ScoreLabel
@onready var live_icon_1 = $Lives/LiveIcon1
@onready var live_icon_2 = $Lives/LiveIcon2
@onready var live_icon_3 = $Lives/LiveIcon3
@onready var new_high_score_label: Label = $NewHighScoreLabel
@onready var multiplier_label: Label = $MultiplierLabel

func update_score_label(score):
    score_label.text = "Score: %d" % score

func update_life_icons(lives):
    live_icon_3.visible = lives>=3
    live_icon_2.visible = lives>=2
    live_icon_1.visible = lives>=1
    
    
func flash_new_high_score_label(flash):
    new_high_score_label.flash(flash)

    
func update_multiplier_label(multiplier):
    multiplier_label.text = "x%d" % multiplier
