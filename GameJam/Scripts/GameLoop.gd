extends Node

var level_scene = preload("res://Scenes/Level.tscn")
@onready var level

@onready var main_menu: Control = $MainMenu
@onready var level_ui: Control = $LevelUI

func _ready() -> void:
    main_menu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
    reset_level()
    end_run()
    update_high_score_label(GameManager.current_high_score)
    pass
    
func start_run():
    get_tree().paused = false
    reset_level()
    main_menu.hide()
    update_score_label(0)
    level_ui.show()

func end_run():    
    get_tree().paused = true
    main_menu.show()
    
func reset_level():
    if (level): level.queue_free()
    level = level_scene.instantiate()
    level.connect("current_run_time_changed", Callable(GameManager, "_on_current_run_time_changed"))
    add_child(level)        

func update_score_label(score):
    level_ui.update_score_label(score)

func update_high_score_label(high_score):
    main_menu.update_high_score_label(high_score)
    
    
    
