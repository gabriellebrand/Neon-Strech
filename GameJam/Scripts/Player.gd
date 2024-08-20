extends CharacterBody3D

# state
const initial_lives = 1
var lives = initial_lives
var invincible = false
var move_z = false

# signals
signal state_changed(new_value)

# stretching constants
const STRETCH_BASE_SPEED = 0.07
const STRETCH_Y_MIN = 0.2
const STRETCH_Y_MAX = 3.0

# low-pass and high-pass filters constants
const LOW_PASS_MAX_STRECTH_CUTOFF_HZ = 3000
const LOW_PASS_NO_CUTOFF_HZ = 10000

const HIGH_PASS_MAX_STRECTH_CUTOFF_HZ = 300
const HIGH_PASS_NO_CUTOFF_HZ = 1

const LOW_PASS_CUTOFF_MULTIPLIER = (LOW_PASS_MAX_STRECTH_CUTOFF_HZ - LOW_PASS_NO_CUTOFF_HZ) / ((1 / STRETCH_Y_MIN) - 1.0)
const LOW_PASS_CUTOFF_CONSTANT = LOW_PASS_NO_CUTOFF_HZ - (LOW_PASS_CUTOFF_MULTIPLIER * 1.0)

const HIGH_PASS_CUTOFF_MULTIPLIER = (HIGH_PASS_MAX_STRECTH_CUTOFF_HZ - HIGH_PASS_NO_CUTOFF_HZ) / (STRETCH_Y_MAX - 1.0)
const HIGH_PASS_CUTOFF_CONSTANT = HIGH_PASS_NO_CUTOFF_HZ - (HIGH_PASS_CUTOFF_MULTIPLIER * 1.0)

const MUSIC_BUS_ID = 1
const LOW_PASS_FILTER_ID = 1
const HIGH_PASS_FILTER_ID = 2
var low_pass_filter = AudioServer.get_bus_effect(MUSIC_BUS_ID, LOW_PASS_FILTER_ID)
var high_pass_filter = AudioServer.get_bus_effect(MUSIC_BUS_ID, HIGH_PASS_FILTER_ID)


# movement constants
const MOVE_SPEED = 4.0
const MOVE_MAX_X = 3.5

func _ready():
    AudioServer.set_bus_effect_enabled(MUSIC_BUS_ID, LOW_PASS_FILTER_ID, false)
    AudioServer.set_bus_effect_enabled(MUSIC_BUS_ID, HIGH_PASS_FILTER_ID, false)
    snap_to_ground()
    reset_state()

func _process(delta):
    stretch_y(Input.get_axis("stretch_down", "stretch_up"))
    snap_to_ground()
    move_x(Input.get_axis("move_left", "move_right"))
    if move_z:
      velocity.z = (GameManager.current_speed)
    move_and_slide()

func reset_state():
    lives = initial_lives
    state_changed.emit(initial_lives)

func move_x(direction):
    velocity.x = (direction * MOVE_SPEED) if direction else move_toward(velocity.x, 0, MOVE_SPEED)
    position.x = clamp(position.x, -MOVE_MAX_X, MOVE_MAX_X)

func stretch_y(value):
    var normalized_scale = (scale.y - STRETCH_Y_MIN) / (STRETCH_Y_MAX - STRETCH_Y_MIN)
    var stretch_factor = 1.05 - pow((normalized_scale - 0.5), 2) * 4.0
    var new_scale_y = scale.y + value * STRETCH_BASE_SPEED * stretch_factor
    new_scale_y = clamp(new_scale_y, STRETCH_Y_MIN, STRETCH_Y_MAX)
    scale.x = 1 / new_scale_y
    scale.y = new_scale_y
    
    if (scale.y == 1.0):
        AudioServer.set_bus_effect_enabled(MUSIC_BUS_ID, LOW_PASS_FILTER_ID, false)  
        AudioServer.set_bus_effect_enabled(MUSIC_BUS_ID, HIGH_PASS_FILTER_ID, false)
    elif (scale.y > 1.0):
        high_pass_filter.cutoff_hz = HIGH_PASS_CUTOFF_MULTIPLIER * scale.y + HIGH_PASS_CUTOFF_CONSTANT
        AudioServer.set_bus_effect_enabled(MUSIC_BUS_ID, LOW_PASS_FILTER_ID, false)
        AudioServer.set_bus_effect_enabled(MUSIC_BUS_ID, HIGH_PASS_FILTER_ID, true)
    else:
        low_pass_filter.cutoff_hz = LOW_PASS_CUTOFF_MULTIPLIER * scale.x + LOW_PASS_CUTOFF_CONSTANT        
        AudioServer.set_bus_effect_enabled(MUSIC_BUS_ID, LOW_PASS_FILTER_ID, true)
        AudioServer.set_bus_effect_enabled(MUSIC_BUS_ID, HIGH_PASS_FILTER_ID, false)

func snap_to_ground():
    position.y = scale.y / 2.0

# called on collision with walls
func hit():
    if invincible: return

    lives -= 1
    state_changed.emit(lives)

    # game over
    if lives <= 0:
        move_z = true
        GameManager.end_run()
        return

    # player is invincible for some time (avoid multiple collision)
    invincible = true
    await get_tree().create_timer(0.5).timeout
    invincible = false
