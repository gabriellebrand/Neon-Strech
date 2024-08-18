extends Label

@onready var flash_timer: Timer = $FlashTimer

func flash():
    flash_timer.start()

func _on_flash_timer_timeout() -> void:
    visible = not visible;
