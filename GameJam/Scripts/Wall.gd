extends Node3D


@onready var wall_part_top = $WallPartTop
@onready var wall_part_left = $WallPartLeft
@onready var wall_part_right = $WallPartRight

# hit
const red = Color(200, 0, 0, 0.5)

# wall dimensions
const wh = 6.0
const ww = 9.0

# min and max z depth for walls
# wall spawns at z=z_initial and moves up to a positive z=z_final
const z_initial = -GameManager.wall_spawn_distance_to_player
const z_final = 4

# hole min/max dimensions
const hole_h_min = 0.5
const hole_h_max = 4.0
const hole_area = 3.0


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

    # top
    wall_part_top.position = Vector3(orig, wh-((wh-h)/2.0), 0)
    wall_part_top.scale = Vector3(w, wh-h, 1)

    # left
    wall_part_left.position = Vector3(-dx + orig/2, wh/2, 0)
    wall_part_left.scale = Vector3(bx+orig, wh, 1)

    # right
    wall_part_right.position = Vector3(dx + orig/2, wh/2, 0)
    wall_part_right.scale = Vector3(bx-orig, wh, 1)


func _process(delta):
    position.z += GameManager.current_speed * delta
    if position.z >= 0:
        var c = wall_part_top.mesh.material.albedo_color
        c.a = 0.5 - position.z/z_final
        wall_part_top.mesh.material.albedo_color = c
        wall_part_left.mesh.material.albedo_color = c
        wall_part_right.mesh.material.albedo_color = c
    if position.z >= z_final:
        queue_free()


func on_hit():
    wall_part_left.mesh.material.albedo_color = red
    wall_part_right.mesh.material.albedo_color = red
    wall_part_top.mesh.material.albedo_color = red
