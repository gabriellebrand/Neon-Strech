extends Label

@onready var flash_timer: Timer = $FlashTimer

func flash(should_flash):
    flash_timer.start() if should_flash else flash_timer.stop()

func _on_flash_timer_timeout() -> void:
    visible = not visible;
