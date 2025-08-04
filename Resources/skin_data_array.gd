extends Resource
class_name AtlasTextureArray
@export var _array:Array[SkinData]

func get_skin(index:int) -> SkinData:
	return _array[index]
