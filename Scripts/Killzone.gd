extends Area3D

@onready var wall = $"../.."

func _on_body_entered(body):
    body.hit()
    wall.on_hit()
