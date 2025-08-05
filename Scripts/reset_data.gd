extends Button

func _ready() -> void:
	button_down.connect(func():
		SaveManager.data = {}
		SaveManager.save_data()
		GameManager.init()
		SceneManager.reload_scene())
