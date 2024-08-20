extends Node

@export var bpm := 100
@export var measures := 4

# Tracking the beat and song position
var loop_counter = 0
var song_position = 0.0
var song_position_in_beats = 1
var sec_per_beat = 60.0 / bpm
var last_reported_beat = 0
var beats_before_start = 1
var measure = 1

# Determining how close to the beat an event is
var closest = 0
var time_off_beat = 0.0

signal beat_changed(position)
signal measure_changed(position)
signal loop_changed(loop_counter)

func _ready():
    sec_per_beat = 60.0 / bpm

func _process(delta):
    song_position += delta
    song_position_in_beats = int(floor(song_position / sec_per_beat)) + beats_before_start
    _report_beat()

func _report_beat():
    if last_reported_beat != song_position_in_beats:
        if (song_position_in_beats % (2 * measures) == 1):
            emit_signal("loop_changed", loop_counter)
            loop_counter += 1
        if measure > measures:
            measure = 1
        emit_signal("beat_changed", song_position_in_beats)
        emit_signal("measure_changed", measure)
        last_reported_beat = song_position_in_beats
        measure += 1
        

func play_with_beat_offset(num):
    beats_before_start = num
    $StartTimer.wait_time = sec_per_beat
    $StartTimer.start()
