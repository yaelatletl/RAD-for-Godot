# This script determines the behaviour of any projectile
extends RigidBody
export(PackedScene) var explosion = preload("res://BaseGD/Guns/explosion.tscn")

# variables for position and speed
var pos
export var speed = 25
export var propelled = false
export var explosive = false
export var energy = false


var wielder

export var damage = 10


func setup(wieldee):
	wielder = wieldee

func _physics_process(delta):
	if propelled:
		propel()
		

func propel():
	# determine basis for flight
	var dir = get_global_transform().basis*Vector3(0,0,-1).normalized()
	
	# exert impulse on bolt to propel it.
	set_linear_velocity(Vector3(dir * speed))
	apply_impulse(Vector3(),dir * speed ) 

func _ready():
	# set transform relative to global
	set_as_toplevel(true)
	
	# get current position/orientation
	pos = get_transform()
	

	

# when the hitbox collides with something:
func _on_Area_body_entered(body):

	# if its a character or object (wall, etc)
	if body is StaticBody or body is RigidBody or body is KinematicBody:
		
		# so long as the object is NOT the bolt itself (since the bolt is a rigid body)
		if body == wielder:
			pass
		else:
			var splode = explosion.instance()
			if explosive:
				splode.set_as_toplevel(true)
				splode.set_global_transform(get_global_transform())

			if body.owner == null:
				pass
			else:
				body.owner.add_child(splode)
			# have some effect (right now it just queues free.
			queue_free()


		if body.has_method("hit"):
			body.hit()
			queue_free()


