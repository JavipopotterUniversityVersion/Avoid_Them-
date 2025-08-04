extends Control
class_name ShopHandler

@export var grid_container:GridContainer
@export var title_label:Label
@export var skin_texture:TextureRect
@export var back_panel:Panel

@export var _skins:AtlasTextureArray
@export var _buy_button:Button

var _selected_button_skin:TextureRect
var _selected_skin:SkinData

func _ready() -> void:
	for button:Button in grid_container.get_children():
		if button.get_index() >= _skins._array.size(): 
			button.visible = false
		else:
			var skin_data:SkinData = _skins.get_skin(button.get_index())
			var button_skin:TextureRect = button.get_node("Skin")
			button_skin.texture = skin_data.icon
			button.set_meta("SkinData", skin_data)
			button.button_down.connect(func(): select_skin(button))
			
			if skin_data.bought: button_skin.self_modulate = Color.WHITE
			else: button_skin.self_modulate = Color.BLACK
			
	_buy_button.button_down.connect(func():buy(_selected_skin))
	select_skin(grid_container.get_child(0))

func select_skin(button:Button):
	_selected_button_skin = button.get_node("Skin")
	_selected_skin = button.get_meta("SkinData")
	skin_texture.texture = _selected_skin.icon
	title_label.text = _selected_skin.name
	update_UI()

func update_UI():
	if _selected_skin.bought: 
		if _selected_skin == GameManager.get_skin():
			back_panel.self_modulate = Color.GREEN
		else: back_panel.self_modulate = Color.WHITE
		skin_texture.self_modulate = Color.WHITE
		_buy_button.text = "Select"
	else: 
		skin_texture.self_modulate = Color.BLACK
		back_panel.self_modulate = Color.RED
		_buy_button.text = "Buy"

func buy(skin_data:SkinData):
	if skin_data.bought:
		GameManager.set_skin(skin_data)
	else:
		if skin_data.try_buy(): 
			_selected_button_skin.self_modulate = Color.WHITE
	update_UI()
