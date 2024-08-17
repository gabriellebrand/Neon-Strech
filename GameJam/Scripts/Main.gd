extends Node3D

const wall_scene = preload("res://Scenes/Wall.tscn")

var run_time = 0;

func _process(delta):
  run_time += delta


func _on_timer_timeout():
    var wall = wall_scene.instantiate()
    add_child(wall)


func end_game():
  get_tree().change_scene_to_file("res://Scenes/UI/MainMenu.tscn")
