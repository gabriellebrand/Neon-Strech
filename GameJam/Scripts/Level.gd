extends Node3D

const wall_scene = preload("res://Scenes/Wall.tscn")

@onready var background_vinyl = $BackgroundVinyl

var current_run_time = 0;
signal current_run_time_changed(run_time)

func _process(delta):
    current_run_time += delta
    emit_signal("current_run_time_changed", current_run_time)
    background_vinyl.rotate(Vector3(0,0,1), delta)

func _on_timer_timeout():
    add_child(wall_scene.instantiate())
