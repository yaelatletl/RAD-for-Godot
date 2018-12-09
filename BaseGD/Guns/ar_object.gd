#This script determines the bahvaiour of weapons that are laying on the ground.
extends Spatial

# stores the mesh for this object
var mesh

# stores the kind of item it is (to be displayed perhaps?)
var identity = "M.75 Assault Rifle"
var item_object = load("res://BaseGD/Guns/ma75.tscn")

# if something collides with the area
func _on_Area_body_entered(body):
	# check to see if that object has a method called "pick_up"
	if body.has_method("pick_up"):
		body.pick_up(item_object)
		queue_free()

