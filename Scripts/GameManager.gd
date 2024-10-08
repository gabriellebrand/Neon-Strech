extends Node

@onready var entry_point: Node = get_tree().get_first_node_in_group("EntryPoint")

const SAVE_DATA = preload("res://Resources/save_data.tres")

@onready var current_score = 0
@onready var current_high_score = SAVE_DATA.high_score
@onready var has_new_high_score = false
@onready var current_multiplier = 1
@onready var stop_incrementing_score = false

@onready var starting_bpm = 100
@onready var current_bpm = starting_bpm
@onready var bpm_acceleration = (60.0/current_bpm) * 8 * 0.3

const wall_spawn_distance_to_player = 12
const beats_to_player =  4

@onready var current_speed:
    set(new_speed):
        current_speed = new_speed
        current_bpm = 60.0 * current_speed / (wall_spawn_distance_to_player * beats_to_player)
    get:
        return wall_spawn_distance_to_player * (current_bpm/60.0) / beats_to_player

@onready var initial_speed = wall_spawn_distance_to_player * (starting_bpm/60.0) / beats_to_player

func _process(delta: float) -> void:
    current_bpm += bpm_acceleration * delta
    
func start_run():
    stop_incrementing_score = false
    Engine.time_scale = 1
    current_bpm = starting_bpm
    current_score = 0
    entry_point.start_run()
    
func end_run():
    stop_incrementing_score = true
    Engine.time_scale = 0.5
    entry_point.slow_down_all_tracks()
    await get_tree().create_timer(0.7).timeout

    if (has_new_high_score):
        entry_point.update_high_score_label(current_high_score)
        var new_save_date = SaveData.new()
        new_save_date.high_score = current_high_score
        ResourceSaver.save(new_save_date, "res://Resources/save_data.tres")
    entry_point.end_run()

func _on_current_streak_changed(streak):
    current_multiplier = 2 ** (streak)
    entry_point.update_multiplier_label(current_multiplier)

func _on_measure_changed(measure):
    if stop_incrementing_score:
        return
    current_score += 50 * current_multiplier
    entry_point.update_score_label(current_score)
    if (current_score > current_high_score):
        current_high_score = current_score
        has_new_high_score = true
        entry_point.flash_new_high_score_label()
