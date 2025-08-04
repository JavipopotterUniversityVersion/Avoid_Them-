extends Node
@export var _song_name:String

func _ready() -> void:
	AudioManager.play_song(_song_name)
