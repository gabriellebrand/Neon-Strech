extends Node3D

const wall_scene = preload("res://Scenes/Wall.tscn")

func _process(delta):
    pass

func _on_timer_timeout():
    var wall = wall_scene.instantiate()
    add_child(wall)
