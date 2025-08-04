extends Node
var _pools:Dictionary = {
	"blood_fx" : preload("res://Prefabs/blood_fx.tscn")
}
const POOL_SIZE:int = 10
var _current_pools:Dictionary

func _ready() -> void:
	for key in _pools:
		var pool = _current_pools.get_or_add(key, [])
		var scene = _pools[key]
		for n in POOL_SIZE:
			var obj = scene.instantiate()
			add_child(obj)
			pool.push_back(obj)

func get_object(object_name:String) -> Node2D:
	var selected_pool:Array = _current_pools[object_name]
	var object = selected_pool.pop_front()
	selected_pool.push_back(object)
	return object
