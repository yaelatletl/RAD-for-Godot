extends "res://BaseGD/Guns/object.gd"

func _ready():
	id = 3
	type = "Zeus Class Fusion Pistol Cell"

func _on_Area_body_entered(body):
	if body.has_method("pick_up"):
		body.pick_up(id, "ammo")
		queue_free()
