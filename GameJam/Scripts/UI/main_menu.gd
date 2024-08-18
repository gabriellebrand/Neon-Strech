extends Control

@onready var high_score_label: Label = $VBoxContainer/HighScoreLabel

func _ready():
    update_high_score_label(0)
    
func _process(delta):
    if Input.is_action_just_pressed("menu_confirm"):
        _on_play_button_pressed()

func _on_play_button_pressed():
    GameManager.start_run()
    
func update_high_score_label(score):
    high_score_label.text = "Score: %08d" % score
