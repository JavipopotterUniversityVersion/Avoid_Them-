extends CanvasLayer

func _ready() -> void:
	hide()
	GameManager.on_game_over.connect(on_game_over)

func on_game_over():
	show()
