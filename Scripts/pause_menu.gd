extends CanvasLayer
@onready var _ui:Control = $"UI"
func _ready() -> void:
	_ui.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		toggle_ui()

func toggle_ui():
	_ui.visible = not _ui.visible
	if _ui.visible: GameManager.pause()
	else: GameManager.resume()
