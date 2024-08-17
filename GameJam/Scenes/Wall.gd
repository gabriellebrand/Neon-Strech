extends StaticBody3D

@export var speed = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  position = position + speed * delta * Vector3(0,0,1)
  if position.z >= 5:
    queue_free()
