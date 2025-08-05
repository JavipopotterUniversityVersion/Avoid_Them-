class_name SkinData
extends Resource

@export var name:String = "Umi"
@export var icon:AtlasTexture
@export var textures:Array[Texture2D]

@export var price:int = 10
@export var bought:bool = false
@export var damage:int = 1

func get_sprite(index:int):
	index = clamp(index, 0, textures.size() - 1)
	return textures[index]

func try_buy() -> bool:
	if GameManager.try_buy(price):
		bought = true
		save_skin()
	return bought

func save_skin():
	SaveManager.data.get_or_add(name, {"bought":bought}).bought = bought

func load_skin():
	var data = SaveManager.data.get_or_add(name, {"bought":bought})
	bought = data.bought
