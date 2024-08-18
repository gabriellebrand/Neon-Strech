extends Control

@onready var high_score_label: Label = $VBoxContainer/HighScoreLabel

func _ready() -> void:
    set_high_score(0)
    
func _process(delta):
    pass

func _on_play_button_pressed() -> void:
    print("play")
    GameManager.start_game()
    
func set_high_score(score):
    high_score_label.text = "High Score: " + str(score)
