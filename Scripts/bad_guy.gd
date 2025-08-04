extends RigidBody2D
@onready var speed:float = randf_range(80, 200)
var INITIAL_SPEED:float

@onready var area = $Area
@onready var button = $Button
@onready var target:Node2D = get_tree().get_first_node_in_group(&"Face")

const ENEMIES_AMOUNT:int = 2
signal on_disable
var _follow:bool = true
@export var _skins:Array[Texture2D]
@export var _skin:Sprite2D
var _health:int = 1

var direction:Vector2

func _ready() -> void:
	INITIAL_SPEED = speed
	area.area_entered.connect(on_area_entered)
	button.button_down.connect(on_press)
	
	_health = GameManager.get_current_level()
	
	_follow = not GameManager.paused
	GameManager.on_game_over.connect(func():_follow = false)
	GameManager.on_pause.connect(func():_follow = false)
	GameManager.on_resume.connect(func():_follow = true)
	
	_skin.set_texture(_skins.pick_random())

func on_press():
	_health -= GameManager.get_skin_damage()
	direction = (global_position - target.global_position).normalized()
	speed = INITIAL_SPEED * 10
	if _health <= 0: kill()

func kill():
	Camera.shake_camera(1.03,Vector2(4, 4))
	GameManager.enemy_kill()
	die()

func die():
	AudioManager.play_sound(&"Destroy")
	on_disable.emit()
	var particles = FxPooler.get_object(&"blood_fx")
	particles.emitting = true
	particles.global_position = global_position
	queue_free()

func on_area_entered(face:Face):
	if face:
		die()
		face.get_damage()
		queue_free()

func _physics_process(delta: float) -> void:
	if _follow:
		direction = direction.lerp((target.global_position - global_position).normalized(), 0.1)
		speed = lerp(speed, INITIAL_SPEED, 0.2)
		linear_velocity = direction * speed
	else:
		linear_velocity = Vector2.ZERO
