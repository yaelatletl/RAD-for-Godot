extends "res://BaseGD/Guns/object.gd"

func _ready():
	id = 1
	type = "52 round .32 caliber Clip"

func _on_Area_body_entered(body):
	if body.has_method("pick_up"):
		body.pick_up(id, "ammo")
		queue_free()
