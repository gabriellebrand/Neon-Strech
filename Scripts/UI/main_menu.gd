extends Control

@onready var high_score_label: Label = $VBoxContainer/HighScoreLabel
@onready var button_audio_stream_player = $ButtonAudioStreamPlayer

func _ready():
    update_high_score_label(0)

func _process(delta):
    if Input.is_action_just_pressed("menu_confirm"):
        _on_play_button_pressed()

func _on_play_button_pressed():
    if visible:
        button_audio_stream_player.play()
        self.hide()
        await get_tree().create_timer(0.3).timeout
        GameManager.start_run()

func update_high_score_label(score):
    high_score_label.text = "Highest Score: %d" % score
