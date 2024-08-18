extends Area3D

func _on_body_entered(body):
    body.hit()
    if body.lives < 0:
        GameManager.reset_game()
