extends MeshInstance3D

var time = 0.0
var material;

func _ready():
    material = get_surface_override_material(0)

func _process(delta):
    time += delta
    material.set_shader_parameter("time", time)
