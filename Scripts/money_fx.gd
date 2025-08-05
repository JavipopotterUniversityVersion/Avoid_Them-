extends Node2D
@onready var texture = preload("res://Sprites/Coin.png")

@export var particles_amount = 35
@export var target_point:Node2D
@export var distance_range:Vector2
@export var time_range:Vector2

var coins_pool:Array[Sprite2D]

func _ready() -> void:
	GameManager.on_gain_money.connect(gain_money)
	for i in range(0, particles_amount):
		var coin = Sprite2D.new()
		coin.texture = texture
		add_child(coin)
		coins_pool.push_back(coin)
		coin.visible = false

func gain_money(amount:int):
	amount = clamp(amount, 0, particles_amount)
	for index in amount:
		var coin = coins_pool[index]
		coin.visible = true
		coin.position = Vector2.ZERO
		launch(coin)

func launch(coin:Sprite2D):
	var tween = create_tween()
	var distance = randf_range(distance_range.x, distance_range.y)
	var random_pos = (Vector2.from_angle(randf_range(0, 2 * PI)) * distance) + global_position
	var random_time = randf_range(time_range.x, time_range.y)
	
	tween.tween_property(coin, "global_position", random_pos,  0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(coin, "global_position", target_point.global_position, random_time)
	await tween.finished
	coin.visible = false
