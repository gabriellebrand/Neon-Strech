extends Node

var play_time = 0
func _process(delta: float) -> void:
    var effect = AudioServer.get_bus_effect(1, 0)
    play_time += delta
    effect.pitch_scale = 1 + (0.05 * (play_time / 4.78))
