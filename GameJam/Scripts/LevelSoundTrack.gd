extends Node

@onready var drums_audio_stream_player = $DrumsAudioStreamPlayer
@onready var bass_audio_stream_player: AudioStreamPlayer = $BassAudioStreamPlayer
@onready var synth_audio_stream_player: AudioStreamPlayer = $SynthAudioStreamPlayer
@onready var synth_voices_audio_stream_player: AudioStreamPlayer = $SynthVoicesAudioStreamPlayer

var play_time = 0
func _process(delta: float) -> void:
    var effect = AudioServer.get_bus_effect(1, 0)
    play_time += delta
    effect.pitch_scale = 1 + (0.025 * (play_time / 4.78))


func _on_conductor_loop_changed(loop_counter) -> void:
    if loop_counter == 1:
        drums_audio_stream_player.volume_db = 0
    elif loop_counter == 2:
        bass_audio_stream_player.volume_db = 0
    elif loop_counter == 4:
        synth_audio_stream_player.volume_db = 0        
    elif loop_counter == 8:
        print("oito")
        synth_voices_audio_stream_player.volume_db = 0
