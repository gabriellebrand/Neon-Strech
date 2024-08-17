extends Area3D

func die():
    print("Died!")
    get_tree().reload_current_scene()

func _on_body_entered(body):
    die()

func _on_area_entered(area):
    die()
