# basic item spawner
# place in scene and then select either "ammo", "powerup", or "weapon".
# if ammo select integer from 0 - 7
# if powerup, 0 - 2
# if weapon 0 - 6


extends Node
#var id = 0
#var type = "none"

export(String, "ammo", "weapon", "object") var object_type
export var object_id = 0
export var spawn_on_ground = false
export var teleport_in = false
export var amount = 1


# stores the location of guns
var ma75 = load("res://BaseGD/Guns/ma75.tscn")
var fpistol = load("res://BaseGD/Guns/fusion_pistol.tscn")
var magnum = load("res://BaseGD/Guns/magnum.tscn")
var tozt = load("res://BaseGD/Guns/magnum.tscn")
var spnkr = load("res://BaseGD/Guns/magnum.tscn")
var smg = load("res://BaseGD/Guns/magnum.tscn")

var weapons = [magnum, ma75, fpistol, tozt, spnkr,smg]


# stores the location of gun objects
var ma75o = load("res://BaseGD/Guns/ma75_object.tscn")
var fpistolo = load("res://BaseGD/Guns/fusion_object.tscn")
var magnumo = load("res://BaseGD/Guns/magnum_object.tscn")
var tozto = load("res://BaseGD/Guns/magnum.tscn")
var spnkro = load("res://BaseGD/Guns/magnum.tscn")
var smgo = load("res://BaseGD/Guns/magnum.tscn")

var weapon_objects = [magnumo, ma75o, fpistolo, tozto, spnkro,smgo]

# stores the location of ammo meshes.
var ma75_rounds = load("res://BaseGD/Guns/ma75_rounds.tscn")
var ma75_grenades = load("res://BaseGD/Guns/ma75_grenades.tscn")
var magnum_rounds = load("res://BaseGD/Guns/magnum_rounds.tscn")
var spnkr_missiles = load("res://BaseGD/Guns/ma75.tscn")
var tozt_can = load("res://BaseGD/Guns/ma75.tscn")
var fp_cell = load("res://BaseGD/Guns/fp_cell.tscn")

var ammo = [magnum_rounds, ma75_rounds, ma75_grenades, fp_cell, tozt_can, spnkr_missiles]

# store location of powerup meshes
var overshield = load("res://BaseGD/Guns/ma75.tscn")
var nightvision = load("res://BaseGD/Guns/ma75.tscn")
var invisibility = load("res://BaseGD/Guns/ma75.tscn")

var powerups = [overshield, nightvision, invisibility]

func _ready():
	spawn()



func spawn():
	$placeholder_cone.set_visible(false)
	
	for i in range(amount):
		
		if object_type == "ammo":
			var shown_object = ammo[object_id]
			$drop.add_child(shown_object.instance())
		if object_type == "weapon":
			var shown_object = weapon_objects[object_id]
			$drop.add_child(shown_object.instance())
		if object_type == "powerup":
			var shown_object = powerups[object_id]
			$drop.add_child(shown_object.instance())

# if something collides with the area
func _on_Area_body_entered(body):
	# check to see if that object has a method called "pick_up"
	
	if body.has_method("pick_up"):
		if object_type == "ammo":
			body.pick_up(object_id, "ammo")
		if object_type == "powerup":
			body.pick_up(object_id, "powerup")
		if object_type == "weapon":
			body.pick_up(weapons[object_id], "weapon")

		queue_free()
