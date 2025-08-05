extends Node
signal on_game_over
signal on_game_start
signal on_enemy_kill
signal on_game_win

signal on_money_changed
signal on_gain_money

signal on_pause
signal on_resume

var paused:bool = false

var _current_score:int = 0
var _high_score:int = 0

var _current_money:int = 0

var _current_level:int = 1
func get_current_level() -> int: return _current_level

@onready var skin:SkinDataReference = preload("res://Resources/player_skin.tres")
@onready var faces:AtlasTextureArray = preload("res://Resources/Faces.tres")

func set_skin(new_value:SkinData):
	SaveManager.data.skin_index = faces._array.find(new_value)
	SaveManager.save_data()
	skin.value = new_value
func get_skin(): return skin.value

var _game_over:bool = false

func get_skin_damage():
	return skin.value.damage

func _ready() -> void:
	init()

func init():
	SaveManager.load_data()
	set_money(SaveManager.data.get_or_add("current_money", 0))
	_current_level = SaveManager.data.get_or_add("current_level", 1)
	var skin_index = SaveManager.data.get_or_add("skin_index", 0)
	skin.value = load("res://Resources/Faces.tres")._array[skin_index]

func add_money(value:int) -> void:
	on_gain_money.emit(value)
	set_money(_current_money + value)
	
func set_money(value:int) -> void:
	_current_money = value
	on_money_changed.emit(_current_money)
	_save_current_money()

func try_buy(price:int) -> bool:
	if price <= _current_money:
		set_money(_current_money - price)
		return true
	else: return false

func enemy_kill():
	_current_score += 1
	on_enemy_kill.emit(_current_score)

func game_over():
	_game_over = true
	if _current_score > _high_score: _high_score = _current_score
	get_scored_money(1)
	on_game_over.emit()

func get_scored_money(multiplier):
	add_money(_current_score * multiplier)
	_current_score = 0

func start_game(): 
	resume()
	_game_over = false
	on_game_start.emit()

func win_game(): 
	if _game_over: return
	_current_level += 1
	SaveManager.data.current_level = _current_level
	SaveManager.save_data()
	on_game_win.emit()
	
func _save_current_money():
	SaveManager.data.current_money = _current_money
	SaveManager.save_data()

func pause():
	paused = true
	on_pause.emit()

func resume():
	paused = false
	on_resume.emit()
