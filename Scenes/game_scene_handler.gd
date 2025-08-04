extends Node2D
@onready var game_over_canvas:CanvasLayer = $"GameOver"

func _ready() -> void:
	game_over_canvas.visible = false
	GameManager.start_game()
	GameManager.on_game_over.connect(on_game_over)

func on_game_over():
	game_over_canvas.visible = true
