extends "res://BaseGD/Guns/object.gd"

func _ready():
	id = 2
	type = "7 round 20mm Grenade Pack"

func _on_Area_body_entered(body):
	if body.has_method("pick_up"):
		body.pick_up(id, "ammo")
		queue_free()
