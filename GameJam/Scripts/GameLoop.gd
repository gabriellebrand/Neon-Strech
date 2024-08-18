extends Node

var level_scene = preload("res://Scenes/Main.tscn")
@onready var level

@onready var main_menu: Control = $MainMenu
@onready var level_ui: Control = $LevelUI

func _ready():
    main_menu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
    level_ui.hide()
    reset_level()
    reset_game()

func _process(delta):
    var player = level.get_node("Player")
    if player.lives<3: level_ui.get_node("Lives/LiveIcon3").hide()
    if player.lives<2: level_ui.get_node("Lives/LiveIcon2").hide()
    if player.lives<1: level_ui.get_node("Lives/LiveIcon1").hide()

func reset_game():
    get_tree().paused = true
    main_menu.show()

func start_game():
    get_tree().paused = false
    reset_level()
    main_menu.hide()
    level_ui.show()
    level_ui.get_node("Lives/LiveIcon1").show()
    level_ui.get_node("Lives/LiveIcon2").show()
    level_ui.get_node("Lives/LiveIcon3").show()

func reset_level():
    if (level): level.queue_free()
    level = level_scene.instantiate()
    add_child(level)

func set_score(score):
    var score_label = level_ui.get_node("ScoreLabel")
    score_label.text = "Score: %10d" % score
