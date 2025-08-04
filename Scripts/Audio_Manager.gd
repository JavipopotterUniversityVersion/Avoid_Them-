extends Node
var current_theme:AudioStreamPlayer = null

func play_song(name:String):
	if current_theme != null:
		current_theme.stop()
	current_theme = play_sound(name)

func play_sound(name:String):
	var audio_player:AudioStreamPlayer = get_node(name)
	audio_player.play()
	return audio_player

func stop_sound(name:String):
	var audio_player:AudioStreamPlayer = get_node(name)
	audio_player.stop()
