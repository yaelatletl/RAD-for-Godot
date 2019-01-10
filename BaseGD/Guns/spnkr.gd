extends "res://BaseGD/Guns/weapon.gd"

export(PackedScene) var Projectile = preload("res://BaseGD/Guns/spnkr_missile.tscn")
export(PackedScene) var squib = preload("res://BaseGD/Guns/squib.tscn")

export var spread = 20


func _ready():
	identity = "SPNKR-X17 SSM Launcher (Lazyboy)"
	in_magazine = 100
	in_secondary_magazine = 0
	primary_magazine_size = 2
	secondary_magazine_size = 0
	primary_ammo_id = 4
	secondary_ammo_id = 4
	
func primary_fire():
	
	#check if the weapon has cooled
	if can_shoot:
		
		
		# check if there is ammo in the magazine
		if ammo_check_primary():
			# load a bolt as an instance
				var missile = Projectile.instance()
				missile.setup(wielder)
				# add the bolt to the aperture of the fusion pistol
				$aperture.add_child(missile)

			# weapon set not chambered, start timer for cooldown.
				can_shoot=false
				$chamber_timer.start()

func secondary_fire():
	primary_fire()
	
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


