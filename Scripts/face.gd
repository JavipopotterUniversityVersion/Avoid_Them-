class_name Face
extends Area2D

@onready var particles:GPUParticles2D = $"Particles"
@onready var background_shader:ShaderMaterial = preload("res://Materials/background_mat.tres")
@onready var background_gradients:Array
@onready var sprite:Sprite2D = $Sprite2D

var skin_data:SkinData = preload("res://Resources/player_skin.tres").value
var _max_health = 9
var _current_health = 9
const REFERENCE_SIZE := 92.0

func list_files_in_directory(path):
	var files = []
	var dir = DirAccess.open(path)
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(load(path + "/" + file))
	return files

func _ready() -> void:
	background_gradients = list_files_in_directory("res://Resources/Gradients")
	_max_health = skin_data.textures.size() - 1
	_current_health = _max_health
	sprite.texture = skin_data.get_sprite(_current_health)
	sprite.scale.x = REFERENCE_SIZE / sprite.texture.get_width()
	sprite.scale.y = sprite.scale.x
	

func get_damage():
	HitStopManager.hit_stop_short()
	Camera.shake_camera(1.15,Vector2(10, 10))
	AudioManager.play_sound("Pain")
	
	sprite.texture = skin_data.get_sprite(_current_health)
	
	var offset = _current_health as float/_max_health as float
	background_shader.set_shader_parameter("colour1", background_gradients[0].sample(offset))
	background_shader.set_shader_parameter("colour4", background_gradients[0].sample(offset))
	
	_current_health -= 1
	if _current_health <= 0:
		GameManager.game_over()
	particles.emitting = true
