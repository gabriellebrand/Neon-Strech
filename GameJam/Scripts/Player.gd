extends CharacterBody3D

@export var lives = 3
@export var invincible = false

signal state_changed(new_value)

const MOVE_SPEED = 4.0
const STRETCH_SPEED = 0.07
const MINIMUM_STRETCH_Y = 0.2
const MAXIMUM_STRETCH_Y = 3.0

func _ready():
    snap_to_ground()
    reset_state()

func _process(delta):
    stretch_y(Input.get_axis("stretch_down", "stretch_up"))
    snap_to_ground()
    move(Input.get_axis("move_left", "move_right"))
    move_and_slide()

func reset_state():
    lives = 3

func move(direction):
    velocity.x = (direction * MOVE_SPEED) if direction else move_toward(velocity.x, 0, MOVE_SPEED)

func stretch_y(value):
    var new_scale_y = scale.y + value * STRETCH_SPEED
    new_scale_y = clamp(new_scale_y, MINIMUM_STRETCH_Y, MAXIMUM_STRETCH_Y)
    scale.x = 1 / new_scale_y
    scale.y = new_scale_y

func snap_to_ground():
    position.y = scale.y / 2.0

func hit():
    if invincible: return

    lives -= 1
    state_changed.emit(lives)

    # player is invincible for some time (avoid multiple collision)
    invincible = true
    await get_tree().create_timer(0.5).timeout
    invincible = false
