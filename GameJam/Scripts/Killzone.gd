extends Area3D

func die():
    print("Died!")
    get_tree().change_scene_to_file("res://Scenes/UI/MainMenu.tscn")

func _on_body_entered(body):
    die()

func _on_area_entered(area):
    die()
