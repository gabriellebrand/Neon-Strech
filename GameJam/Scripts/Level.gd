extends Node3D

const wall_scene = preload("res://Scenes/Wall.tscn")

@onready var background_vinyl = $BackgroundVinyl

var current_run_time = 0;
signal current_run_time_changed(run_time)
signal current_streak_changed(current_streak)

const spawn_wall_every_n_beats =  3
var current_beat = 0

var current_streak = 0:
    set(new_streak):
        current_streak = new_streak
        emit_signal("current_streak_changed", current_streak)
    get():
        return current_streak

func _process(delta):
    current_run_time += delta
    emit_signal("current_run_time_changed", current_run_time)
    background_vinyl.rotate(Vector3(0,0,1), delta)

func _on_timer_timeout():
    pass

func _on_conductor_measure_changed(position: Variant) -> void:
    #if (current_beat % spawn_wall_every_n_beats == 0):
        #var wall = wall_scene.instantiate()
        #add_child(wall)
    #current_beat += 1
    
    if (position % 4 == 1):
        var wall = wall_scene.instantiate()
        add_child(wall)

func _on_conductor_loop_changed(loop_counter) -> void:
    current_streak += 1


func _on_player_state_changed(new_value: Variant) -> void:
    current_streak = 0
