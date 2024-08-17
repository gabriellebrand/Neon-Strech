extends CharacterBody3D


const STRETCH_SPEED = 0.1
const MINIMUM_STRETCH_Y = 0.2
const MAXIMUM_STRETCH_Y = 5.0

func _physics_process(delta: float) -> void:	
  var stretch_y_value = Input.get_axis("stretch_down", "stretch_up")
  stretch_y(stretch_y_value)
  snap_to_ground()
  
func stretch_y(value):	
  var new_scale_y = scale.y + value * STRETCH_SPEED
  new_scale_y = clamp(new_scale_y, MINIMUM_STRETCH_Y, MAXIMUM_STRETCH_Y)
  
  scale.x = 1 / new_scale_y
  scale.y = new_scale_y
  
func snap_to_ground():
  position.y = scale.y / 2.0
