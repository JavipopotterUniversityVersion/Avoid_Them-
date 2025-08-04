class_name EnemySpawner
extends Node

@export var _enemies:Array[PackedScene]
@export var _enemies_per_wave:int
var _enemy_count:int = 0
const WAVES:int = 2
signal next_wave
var game_over:bool = false
var paused:bool = false

func _ready() -> void:
	GameManager.on_game_start.connect(spawn_waves)
	GameManager.on_game_over.connect(func(): game_over = true)
	GameManager.on_pause.connect(func(): paused = true)
	GameManager.on_resume.connect(func(): paused = false)

func spawn_waves() -> void:
	await get_tree().create_timer(2).timeout
	
	var wave_index := 0
	while not game_over and wave_index < WAVES:
		for i in range(_enemies_per_wave):
			spawn_enemy_at_border()
			await get_tree().create_timer(randf_range(0.1, 0.5)).timeout
			if paused: await GameManager.on_resume
		await next_wave
		wave_index += 1
	
	GameManager.win_game()

func spawn_enemy_at_border() -> void:
	if _enemies.is_empty(): return
	var enemy_scene:PackedScene = _enemies.pick_random()
	var enemy = enemy_scene.instantiate()

	get_parent().add_child.call_deferred(enemy)
	var spawn_position = get_random_border_position()
	enemy.global_position = spawn_position
	
	enemy.on_disable.connect(_substract_enemy.call_deferred,4)
	_enemy_count += 1

func _substract_enemy():
	_enemy_count -= 1
	if _enemy_count <= 0:
		next_wave.emit()

func get_random_border_position() -> Vector2:
	var viewport := get_viewport()
	var camera := viewport.get_camera_2d()

	var screen_size := viewport.get_visible_rect().size
	var screen_position := camera.get_screen_center_position() - screen_size / 2

	var side := randi() % 3
	var x: float
	var y: float

	match side:
		0: # bottom
			x = randf_range(0, screen_size.x)
			y = screen_size.y
		1: # left
			x = 0
			y = randf_range(0, screen_size.y)
		2: # right
			x = screen_size.x
			y = randf_range(0, screen_size.y)

	return screen_position + Vector2(x, y)
