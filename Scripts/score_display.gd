extends Label

func _ready() -> void:
	GameManager.on_enemy_kill.connect(on_enemy_kill)
	
func on_enemy_kill(value:int):
	text = str(value)
