class_name MoneyDisplay
extends Label

func _ready() -> void:
	on_money_changed(GameManager._current_money)
	GameManager.on_money_changed.connect(on_money_changed)
	
func on_money_changed(value:int):
	text = str(value)
