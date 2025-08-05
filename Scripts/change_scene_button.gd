class_name ChangeSceneButton
extends Button
@export var scene_name:String = "game_scene"

func _ready() -> void:
	button_down.connect(change_scene)

func change_scene():
	if scene_name == "exit": 
		get_tree().quit()
		return
		
	var path:String = "res://Scenes/" + scene_name + ".tscn"
	SceneManager.change_scene(path, { "pattern": "scribbles", "pattern_leave": "squares" })
