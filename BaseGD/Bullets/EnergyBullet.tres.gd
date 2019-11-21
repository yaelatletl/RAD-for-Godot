extends KinematicBody

export(float) var damage = 10
export(float) var speed = 20
export(bool) var follows = false
export(bool) var smart = false
var dead = false

#export(AnimatedSprite) var MainSprite = null
onready var Mask = preload("res://BaseGD/Bullets/Mark.tscn")
var destination = Vector3(0,0,0)
var velocity = Vector3(0,0,0)
var target = null

##Networking
slave var slave_dead
slave var slave_velocity
slave var slave_translation
slave var slave_destination

func normal_movement():
	if is_network_master():
		if target != null:
			if (is_on_ceiling() or is_on_wall() or is_on_floor()): # and $WallCheck.is_colliding(): # (or
				
				var normal = $WallCheck.get_collision_normal()
				var pos = $WallCheck.get_collision_point()
				if $WallCheck.is_colliding():
					if $WallCheck.get_collider() is StaticBody:
						var mark = Mask.instance()
						mark.translation = pos
						mark.look_at(normal)
						get_node("root/").add_child(mark.instance())
					
				dead = true
			if follows:
				#If you use the follows variable you must also set the target or else it will fail
				destination = target.translation
				velocity = (destination).normalized() * speed
				rset("slave_destination", destination)
				rset("slave_velocity", translation)
			else:
				pass
		move_and_slide(velocity)
		rset("slave_translation", translation)
		if translation.distance_to(Vector3(0,0,0)) > 150:
			dead = true
			
		rset("slave_dead", dead)
	else:  # Is not network master
		move_and_slide(velocity)  # Should this be called on both server and client?
		translation = slave_translation
		dead = slave_dead
		velocity = slave_velocity
	if dead:
		set_process(false)
		set_physics_process(false)
		queue_free()
		

func smart_movement():
	pass

func _ready():
	$Area.connect("body_entered", self, "_on_EnergyBullet_body_entered")
	
	if is_network_master():
		destination = Vector3(target.translation.x, target.translation.y + 1.5, target.translation.z) - translation
		velocity = (destination).normalized() * speed
		
		rset("slave_destination", destination)
		rset("slave_velocity", velocity)
		rset("slave_dead", false)
		
	else:
		destination = destination
		velocity = velocity
	
func _process(delta):
	if not dead:
		if smart:
			smart_movement()
		else:
			normal_movement()
	

func _on_EnergyBullet_body_entered(body):
	# TODO: sync health state in body, not here?
	if body is KinematicBody and body.get("health")!=null :
		body.health -= damage
	# TODO: dead = True?
