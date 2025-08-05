extends RichTextLabel
@export var gradient:Gradient

func _ready() -> void:
	var level = GameManager.get_current_level()
	var color:Color = gradient.sample(float(level)/10.0)
	var tag = "[color=%s]" % color.to_html()
	text = "Level: " + tag + str(level)+ "[/color]"
