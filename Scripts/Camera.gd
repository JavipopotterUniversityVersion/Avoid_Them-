extends Camera2D

const INIT_ZOOM:Vector2 = Vector2.ONE
const INIT_OFFSET:Vector2 = Vector2.ZERO

var cur_zoom:Vector2 = INIT_ZOOM
var cur_offset:Vector2 = INIT_OFFSET

var shake_recov_factor:float = 1
var zoom_recov_factor:float = 6
var _follow:bool = true

@onready var target:Node2D = get_tree().get_first_node_in_group("Face")

func _ready():
	zoom = INIT_ZOOM
	offset = INIT_OFFSET
	make_current()
	SceneManager.fade_complete.connect(try_assign_target)

func try_assign_target():
	await get_tree().create_timer(0.1).timeout
	target = get_tree().get_first_node_in_group("Face")

func _process(delta: float) -> void:
	follow_target()
	recover_zoom(delta)
	recover_offset_and_shake(delta)

func recover_offset_and_shake(delta:float) -> void:
	cur_offset = lerp(cur_offset, INIT_OFFSET, delta * shake_recov_factor)
	cur_offset.x = randf_range(cur_offset.x * -1, cur_offset.x * 1)
	cur_offset.y = randf_range(cur_offset.y * -1, cur_offset.y * 1)
	offset = cur_offset

func follow_target():
	if target != null and _follow:
		global_position = target.global_position

func recover_zoom(delta:float):
	cur_zoom = lerp(cur_zoom, INIT_ZOOM, zoom_recov_factor * delta)
	zoom = cur_zoom
	
func set_zoom_str(zoom_str:float):
	cur_zoom *= zoom_str

func set_shake_str(shake_val:Vector2):
	cur_offset += shake_val

func shake_camera(zoom_str:float, shake_val:Vector2):
	set_zoom_str(zoom_str)
	set_shake_str(shake_val)
