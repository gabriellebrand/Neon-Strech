extends Node

var level_scene = preload("res://Scenes/Main.tscn")
@onready var level

@onready var main_menu: Control = $MainMenu
@onready var level_ui: Control = $LevelUI

func _ready() -> void:
    main_menu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
    reset_level()
    reset_game()
    pass
    
func reset_game():
    get_tree().paused = true
    main_menu.show()
    
func start_game():
    get_tree().paused = false
    reset_level()
    main_menu.hide()
    level_ui.show()
    
func reset_level():
    if (level): level.queue_free()
    level = level_scene.instantiate()
    add_child(level)
    
func set_score(score):
    var score_label = level_ui.get_node("ScoreLabel")
    score_label.text = "Score: %10d" % score
    
