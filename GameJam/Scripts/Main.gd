extends Node3D

const wall_scene = preload("res://Scenes/Wall.tscn")

func _process(delta):
  pass

func _on_timer_timeout():
  var wall = wall_scene.instantiate()
  wall.position = Vector3(0,0,-20)
  add_child(wall)
