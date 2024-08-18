extends Node3D

const wall_scene = preload("res://Scenes/Wall.tscn")
const SAVE_DATA = preload("res://Resources/save_data.tres")

var run_time = 0;
var current_score = 0;
signal score_changed(score:int)

func _process(delta):
    run_time += delta
    current_score = compute_score()
    GameManager.set_score(current_score)


func _on_timer_timeout():
    var wall = wall_scene.instantiate()
    add_child(wall)


func end_game():
    if (current_score > SAVE_DATA.high_score):
        print("new high score: " + str(current_score))

func compute_score():
    var score = int(run_time) * 50
    return score
