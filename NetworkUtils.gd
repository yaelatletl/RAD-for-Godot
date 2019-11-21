extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

sync func text_on_head(text, _3dpos, time):
	
	var floater = Label.instance()
	floater.text = text
	floater.position = get_viewport().get_camera().unproject_position(_3dpos)
	get_scene().get_root().add_child(floater)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
