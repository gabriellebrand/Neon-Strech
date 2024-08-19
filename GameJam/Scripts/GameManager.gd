extends Node

@onready var entry_point: Node = get_tree().get_first_node_in_group("EntryPoint")

const SAVE_DATA = preload("res://Resources/save_data.tres")

@onready var current_score = 0
@onready var current_high_score = SAVE_DATA.high_score
@onready var has_new_high_score = false
@onready var current_multiplier = 1

@onready var current_bpm = 100

const wall_spawn_distance_to_player = 12
const beats_to_player =  8

@onready var current_speed:
    set(new_speed):
        current_speed = new_speed
        current_bpm = 60.0 * current_speed / (wall_spawn_distance_to_player * beats_to_player)
    get:
        return wall_spawn_distance_to_player * (current_bpm/60.0) / beats_to_player

func start_run():
    entry_point.start_run()
    
func end_run():
    if (has_new_high_score):
        entry_point.update_high_score_label(current_high_score)
        var new_save_date = SaveData.new()
        new_save_date.high_score = current_high_score
        ResourceSaver.save(new_save_date, "res://Resources/save_data.tres")
    entry_point.end_run()
    
func _on_current_run_time_changed(run_time):
    var new_score = compute_score(run_time)
    if (new_score == current_score):
        return
    
    current_score = new_score
    entry_point.update_score_label(current_score)
    if (current_score > current_high_score):
        current_high_score = current_score
        has_new_high_score = true
        entry_point.flash_new_high_score_label()

func _on_current_streak_changed(streak):
    current_multiplier = 2 ** (streak)
    print(streak, " ", current_multiplier)
    entry_point.update_multiplier_label(current_multiplier)
    

func compute_score(run_time):
    var score = int(run_time) * 50 * current_multiplier
    return score
