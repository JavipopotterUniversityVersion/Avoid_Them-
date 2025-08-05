extends CanvasLayer
@onready var _ui:Control = $UI
@onready var _width:int = _ui.get_rect().size.x
var active:bool
var can_toggle:bool

func _ready() -> void:
	show()
	can_toggle = true
	_ui.position.x = _width

func toggle():
	active = not active
	can_toggle = false
	var tween = create_tween()
	
	if active:
		tween.tween_property(_ui, "position", Vector2.ZERO, 1).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	else:
		tween.tween_property(_ui, "position", Vector2(_width, 0), 1).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN)

	await tween.finished
	can_toggle = true
