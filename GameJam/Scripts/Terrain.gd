extends MeshInstance3D

var material
var mesh_size = 99.0
var spawn_pos = -139.5

func _ready():
    material = get_surface_override_material(0)

func _process(delta):
    position.z += GameManager.current_speed * delta
    
    if (position.z > 60.0):
        position.z -= 2 * mesh_size
        
    
