extends CanvasLayer

func _ready() -> void:
	hide()
	GameManager.on_game_start.connect(show)
