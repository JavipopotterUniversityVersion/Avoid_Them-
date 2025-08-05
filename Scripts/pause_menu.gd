extends CanvasLayer
var can_show:bool = false

func _ready() -> void:
	hide()
	GameManager.on_game_start.connect(enable)
	GameManager.on_game_over.connect(disable)

func _input(event: InputEvent) -> void:
	if not can_show: return
	if event.is_action_pressed("Pause"):
		toggle_ui()

func toggle_ui():
	visible = not visible
	
	if visible: GameManager.pause()
	else: GameManager.resume()

func enable():
	can_show = true

func disable():
	can_show = false
