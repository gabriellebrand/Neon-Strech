extends Area3D

func die():
    GameManager.end_run()

func _on_body_entered(body):
    die()

func _on_area_entered(area):
    die()
