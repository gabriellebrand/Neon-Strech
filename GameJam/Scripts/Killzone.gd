extends Area3D

func _on_body_entered(body):
  print("Died!")
  get_tree().reload_current_scene()
  #timer.start()
