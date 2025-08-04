extends CanvasLayer
@export var next_level_button:Button
@export var claim_button:Button
@export var claim_x2_button:Button
var x2_claimed:bool = false

func _ready() -> void:
	$UI.visible = false
	GameManager.on_game_win.connect(on_win)
	claim_button.button_down.connect(func():
		GameManager.get_scored_money(1)
		allow_next_level())
		
	claim_x2_button.button_down.connect(func():
		GameManager.get_scored_money(2)
		x2_claimed = true
		allow_next_level())

func on_win():
	$UI.visible = true
	claim_button.visible = false
	next_level_button.visible = false
	await get_tree().create_timer(3).timeout
	if x2_claimed: return
	claim_button.visible = true
	claim_button.modulate = Color.TRANSPARENT
	create_tween().tween_property(claim_button, "modulate", Color.WHITE, 1)

func allow_next_level():
	next_level_button.visible = true
	claim_button.visible = false
	claim_x2_button.visible = false
