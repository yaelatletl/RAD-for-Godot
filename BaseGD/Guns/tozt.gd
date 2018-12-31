extends "res://BaseGD/Guns/raycast_weapon.gd"
export(PackedScene) var squib = preload("res://BaseGD/Guns/squib.tscn")

export var spread = 2



func _ready():
	identity = "TOZT-7"
	in_magazine = 210
	in_secondary_magazine = 210
	primary_magazine_size = 210
	secondary_magazine_size = 210
	primary_ammo_id = 5
	secondary_ammo_id = 5

func primary_fire():

	#check if the weapon has cooled
	if can_shoot:

		# adjust ray for random spread


		# check if there is ammo in the magazine
		if ammo_check_primary():

			randomshoot()
			# check for collisions
			
			
			# weapon set not chambered, start timer for cooldown.
			can_shoot=false
			$chamber_timer.start()


func _on_chamber_timer_timeout():
	can_shoot = true

# "M .75 ammunition is neither vacuum enabled nor teflon coated, and due to a manufacturing defect is highly inaccurate at long range."
# used for random spread.
func randomshoot():

	randomize()
	var randx = rand_range(-spread, spread)
	randomize()
	var randy = rand_range(-spread, spread)


	var newx = 0 + randx
	var newy = 0 + randy
	#print("rando =", newx," ", newy)
	#$aperture/RayCast.set_cast_to(Vector3(newx,newy,-1000))


func _on_grenade_timer_timeout():
	can_shoot_secondary = true
	pass # replace with function body
