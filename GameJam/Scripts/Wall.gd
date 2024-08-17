extends Node3D

@export var speed = 2.5

@onready var wall_part_mesh_top = $WallPartMeshTop
@onready var wall_part_mesh_left = $WallPartMeshLeft
@onready var wall_part_mesh_right = $WallPartMeshRight

# wall dimensions
const wh = 4.0
const ww = 8.0

func _ready():
    # wall starts at z=-20 and moves up to a positive z
    position.z = -10

    # hole dimensions
    var h = randf_range(0.5, 4.0)
    var w = 2/h # 2 instead of 1 to have a margin

    # dimension x of left/right wall parts
    var bx = (ww-w)/2

    # distance to center of wall parts
    var dx = (ww-bx)/2
    var dy = wh-((wh-h)/2)

    # top
    wall_part_mesh_top.position = Vector3(0, wh-((wh-h)/2.0), 0)
    wall_part_mesh_top.scale = Vector3(w, wh-h, 1)
    #wall_part_mesh_top.get_node("Killzone").scale = wall_part_mesh_top.scale
    print(wall_part_mesh_top)

    # left
    wall_part_mesh_left.position = Vector3(-dx, wh/2, 0)
    wall_part_mesh_left.scale = Vector3(bx, wh, 1)
    #wall_part_mesh_left.get_node("Killzone").scale = wall_part_mesh_left.scale

    # left
    wall_part_mesh_right.position = Vector3(dx, wh/2, 0)
    wall_part_mesh_right.scale = Vector3(bx, wh, 1)
    #wall_part_mesh_right.get_node("Killzone").scale = wall_part_mesh_right.scale


func _process(delta):
    position.z += speed * delta
    if position.z >= 0.5:
        queue_free()
