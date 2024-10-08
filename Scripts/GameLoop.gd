extends Node

var level_scene = preload("res://Scenes/Level.tscn")
@onready var level

@onready var level_ui: Control = $LevelUI
@onready var main_menu: Control = $MainMenu
@onready var game_over_menu = $GameOverMenu

func _ready():
    #main_menu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
    main_menu.process_mode = Node.PROCESS_MODE_ALWAYS
    game_over_menu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
    level_ui.process_mode = Node.PROCESS_MODE_ALWAYS
    level_ui.hide()
    get_tree().paused = true
    reset_level()
    update_high_score_label(GameManager.current_high_score)

func start_run():
    get_tree().paused = false
    reset_level()
    main_menu.hide()
    game_over_menu.hide()
    level_ui.flash_new_high_score_label(false)
    level_ui.get_node("NewHighScoreLabel").hide()
    level_ui.show()
    update_score_label(0)

# call back for end of game, called by GameManager
func end_run():
    get_tree().paused = true
    game_over_menu.show()

func reset_level():
    if (level): level.queue_free()
    level = level_scene.instantiate()
    level.connect("current_run_time_changed", Callable(GameManager, "_on_current_run_time_changed"))
    level.connect("current_streak_changed", Callable(GameManager, "_on_current_streak_changed"))
    level.get_node("Player").state_changed.connect(player_state_changed)    
    level.get_node("%Conductor").connect("measure_changed", Callable(GameManager, "_on_measure_changed"))
    
    add_child(level)

func update_score_label(score):
    level_ui.update_score_label(score)
    
func update_multiplier_label(multiplier):
    level_ui.update_multiplier_label(multiplier)

func update_high_score_label(high_score):
    main_menu.update_high_score_label(high_score)
    game_over_menu.update_high_score_label(high_score)

# called when player state is changed
func player_state_changed(lives):
    level_ui.update_life_icons(lives)
    
func flash_new_high_score_label():
    level_ui.flash_new_high_score_label(true)
    
func slow_down_all_tracks():
    level.get_node("Sound").slow_down_all_tracks()
    
