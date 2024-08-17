extends Node3D

@export var speed = 5

@onready var mesh_instance_3d_left = $MeshInstance3DLeft
@onready var mesh_instance_3d_right = $MeshInstance3DRight
@onready var mesh_instance_3d_top = $MeshInstance3DTop

func _ready():
  var w = randf_range(0, 2)
  var h = randf_range(0, 2)
  mesh_instance_3d_left.position.x += -w
  mesh_instance_3d_right.position.x += w
  mesh_instance_3d_top.position.y += h


func _process(delta):
  position = position + speed * delta * Vector3(0,0,1)
  if position.z >= 5:
    queue_free()
