# This script determines the behaviour of the fusion bolt (not supercharge)
extends RigidBody
var explosion = load("res://BaseGD/Guns/explosion.tscn")
# variables for position and speed
var pos
export var speed = 10
var wielder

func setup(wieldee):
	wielder = wieldee

func _ready():
	# set transform relative to global
	set_as_toplevel(true)

	# get current position/orientation
	pos = get_transform()

	# determine basis for flight
	var dir = get_global_transform().basis*Vector3(0,0,-1).normalized()

	# exert impulse on bolt to propel it.
	set_linear_velocity(Vector3(dir * speed))
	apply_impulse(Vector3(),dir * speed )


# when the hitbox collides with something:
func _on_Area_body_entered(body):

	# if its a character or object (wall, etc)
	if body is StaticBody or body is RigidBody or body is KinematicBody:

		# so long as the object is NOT the bolt itself (since the bolt is a rigid body)
		if body == wielder:
			pass
		else:
			var splode = explosion.instance()
			splode.set_as_toplevel(true)
			splode.set_global_transform(get_global_transform())
			
		
			#var splodepos = splode.get_global_transform()
			#squibpos.origin = squibpoint
			#thissquib.set_global_transform(squibpos)
			if body.owner == null:
				pass
			else:
				body.owner.add_child(splode)
			# have some effect (right now it just queues free.
			queue_free()

	if body.is_in_group("enemy"):
		if body.has_method("hit"):
			body.hit()
		queue_free()

