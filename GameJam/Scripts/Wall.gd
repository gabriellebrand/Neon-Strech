extends Node3D

@export var speed = 3.5

@onready var wall_part_mesh_top = $WallPartMeshTop
@onready var wall_part_mesh_left = $WallPartMeshLeft
@onready var wall_part_mesh_right = $WallPartMeshRight

# wall dimensions
const wh = 6.0
const ww = 8.0

# min and max z depth for walls
# wall spawns at z=z_initial and moves up to a positive z=z_final
const z_initial = -10
const z_final = 3

# hole min/max dimensions
const hole_h_min = 0.5
const hole_h_max = 4.0
const hole_area = 4.0

func _ready():
    # wall spawn at z_initial
    position.z = z_initial

    # hole dimensions
    var h = randf_range(hole_h_min, hole_h_max)
    var w = hole_area/h

    # dimension x of left/right wall parts
    var bx = (ww-w)/2

    # random hole origin
    var orig = randf_range(-0.9*bx, 0.9*bx)

    # distance to center of wall parts
    var dx = (ww-bx)/2
    var dy = wh-((wh-h)/2)

    # top
    wall_part_mesh_top.position = Vector3(orig, wh-((wh-h)/2.0), 0)
    wall_part_mesh_top.scale = Vector3(w, wh-h, 1)

    # left
    wall_part_mesh_left.position = Vector3(-dx + orig/2, wh/2, 0)
    wall_part_mesh_left.scale = Vector3(bx+orig, wh, 1)

    # right
    wall_part_mesh_right.position = Vector3(dx + orig/2, wh/2, 0)
    wall_part_mesh_right.scale = Vector3(bx-orig, wh, 1)


func _process(delta):
    position.z += speed * delta
    if position.z >= z_final:
        queue_free()
