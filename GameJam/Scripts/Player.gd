extends CharacterBody3D

# state
var lives = 3
var invincible = false

# signals
signal state_changed(new_value)

# stretching constants
const STRETCH_BASE_SPEED = 0.07
const STRETCH_Y_MIN = 0.2
const STRETCH_Y_MAX = 3.0

# movement constants
const MOVE_SPEED = 4.0
const MOVE_MAX_X = 4

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
    state_changed.emit(3)

func move(direction):
    velocity.x = (direction * MOVE_SPEED) if direction else move_toward(velocity.x, 0, MOVE_SPEED)
    position.x = clamp(position.x, -MOVE_MAX_X, MOVE_MAX_X)

func stretch_y(value):
    var normalized_scale = (scale.y - STRETCH_Y_MIN) / (STRETCH_Y_MAX - STRETCH_Y_MIN)
    var stretch_factor = 1.05 - pow((normalized_scale - 0.5), 2) * 4.0
    var new_scale_y = scale.y + value * STRETCH_BASE_SPEED * stretch_factor
    new_scale_y = clamp(new_scale_y, STRETCH_Y_MIN, STRETCH_Y_MAX)
    scale.x = 1 / new_scale_y
    scale.y = new_scale_y

func snap_to_ground():
    position.y = scale.y / 2.0

# called on collision with walls
func hit():
    if invincible: return

    lives -= 1
    state_changed.emit(lives)

    # game over
    if lives <= 0:
        GameManager.end_run()
        return

    # player is invincible for some time (avoid multiple collision)
    invincible = true
    await get_tree().create_timer(0.5).timeout
    invincible = false
