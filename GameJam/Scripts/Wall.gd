extends Node3D

@export var speed = 2.5

@onready var wall_part_mesh_top = $WallPartMeshTop
@onready var wall_part_mesh_left = $WallPartMeshLeft
@onready var wall_part_mesh_right = $WallPartMeshRight

# wall dimensions
const wh = 6.0
const ww = 10.0

# min and max z depth for walls
# wall starts at z=z_initial and moves up to a positive z=z_final
const z_initial = -10
const z_final = 3

# rolw min/max dimensions
const hole_h_min = 0.5
const hole_h_max = 4.0
const hole_area = 2.0

func _ready():
    position.z = z_initial

    # hole dimensions
    var h = randf_range(hole_h_min, hole_h_max)
    var w = hole_area/h

    # dimension x of left/right wall parts
    var bx = (ww-w)/2

    # distance to center of wall parts
    var dx = (ww-bx)/2
    var dy = wh-((wh-h)/2)

    # top
    wall_part_mesh_top.position = Vector3(0, wh-((wh-h)/2.0), 0)
    wall_part_mesh_top.scale = Vector3(w, wh-h, 1)

    # left
    wall_part_mesh_left.position = Vector3(-dx, wh/2, 0)
    wall_part_mesh_left.scale = Vector3(bx, wh, 1)

    # left
    wall_part_mesh_right.position = Vector3(dx, wh/2, 0)
    wall_part_mesh_right.scale = Vector3(bx, wh, 1)


func _process(delta):
    position.z += speed * delta
    if position.z >= z_final:
        queue_free()
