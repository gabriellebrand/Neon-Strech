extends Node3D

const wall_scene = preload("res://Scenes/Wall.tscn")

@onready var background_vinyl = $BackgroundVinyl

var current_run_time = 0;
signal current_run_time_changed(run_time)
signal current_streak_changed(current_streak)

var current_beat = 0

var current_streak = 0:
    set(new_streak):
        current_streak = new_streak
        emit_signal("current_streak_changed", current_streak)


func _process(delta):
    current_run_time += delta
    emit_signal("current_run_time_changed", current_run_time)
    background_vinyl.rotate(Vector3(0,0,-1), GameManager.current_bpm/50.0 * delta)

func _on_conductor_measure_changed(position: Variant) -> void:
    if (position % 4 == 1):
        add_child(wall_scene.instantiate())

func _on_conductor_loop_changed(loop_counter) -> void:
    current_streak += 1

func _on_player_state_changed(new_value: Variant) -> void:
    current_streak = 0
