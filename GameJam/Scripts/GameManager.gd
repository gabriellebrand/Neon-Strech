extends Node

var entry_point: Node
func _ready() -> void:
    entry_point = get_tree().get_first_node_in_group("EntryPoint")
    
func start_game():
    entry_point.start_game()
    
func reset_game():
    entry_point.reset_game()

func set_score(score):
    entry_point.set_score(score)
