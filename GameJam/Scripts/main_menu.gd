extends Control

@onready var high_score_label: Label = $VBoxContainer/HighScoreLabel

func _ready() -> void:
    update_high_score_label(0)
    
func _process(delta):
    pass

func _on_play_button_pressed() -> void:
    GameManager.start_run()
    
func update_high_score_label(score):
    high_score_label.text = "Score: %08d" % score
