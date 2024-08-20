extends Node

@onready var drums_audio_stream_player = $DrumsAudioStreamPlayer
@onready var bass_audio_stream_player: AudioStreamPlayer = $BassAudioStreamPlayer
@onready var synth_audio_stream_player: AudioStreamPlayer = $SynthAudioStreamPlayer
@onready var synth_voices_audio_stream_player: AudioStreamPlayer = $SynthVoicesAudioStreamPlayer

const increase_pitch_speed = (0.02 / 4.78)
var increasing_pitch = true

var last_pitch_speed
var time_to_end = 0.7
var desired_end_pitch = 0.2

var play_time = 0
func _process(delta: float) -> void:
    play_time += delta
    if increasing_pitch:
        drums_audio_stream_player.pitch_scale = 1 + play_time * increase_pitch_speed
        bass_audio_stream_player.pitch_scale = 1 + play_time * increase_pitch_speed
        synth_audio_stream_player.pitch_scale = 1 + play_time * increase_pitch_speed
        synth_voices_audio_stream_player.pitch_scale = 1 + play_time * increase_pitch_speed
    else:
        drums_audio_stream_player.pitch_scale += delta * last_pitch_speed
        bass_audio_stream_player.pitch_scale += delta * last_pitch_speed
        synth_audio_stream_player.pitch_scale += delta * last_pitch_speed
        synth_voices_audio_stream_player.pitch_scale += delta * last_pitch_speed


func _on_conductor_loop_changed(loop_counter) -> void:
    if loop_counter == 1:
        drums_audio_stream_player.volume_db = 0
    elif loop_counter == 2:
        bass_audio_stream_player.volume_db = 0
    elif loop_counter == 3:
        synth_audio_stream_player.volume_db = 0        
    elif loop_counter == 4:
        synth_voices_audio_stream_player.volume_db = 0
        
func slow_down_all_tracks():
    increasing_pitch = false
    var last_pitch = drums_audio_stream_player.pitch_scale
    last_pitch_speed = (desired_end_pitch - last_pitch) / time_to_end
