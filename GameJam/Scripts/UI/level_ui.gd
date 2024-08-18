extends Control

@onready var score_label: Label = $ScoreLabel
@onready var live_icon_1 = $Lives/LiveIcon1
@onready var live_icon_2 = $Lives/LiveIcon2
@onready var live_icon_3 = $Lives/LiveIcon3

func update_score_label(score):
    score_label.text = "Score: %08d" % score

func update_life_icons(lives):
    if lives<3: live_icon_3.hide()
    if lives<2: live_icon_2.hide()
    if lives<1: live_icon_1.hide()
