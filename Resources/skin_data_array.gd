extends Resource
class_name AtlasTextureArray
@export var _array:Array[SkinData]

func load_skins() -> void:
	for skin in _array:
		skin.load_skin()

func get_skin(index:int) -> SkinData:
	return _array[index]
