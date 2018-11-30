extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

sync func _process(delta):
	var pos = get_node("../TextPoint").to_global(get_node("../TextPoint").transform.origin)
	rect_position = get_viewport().get_camera().unproject_position(pos)
	
