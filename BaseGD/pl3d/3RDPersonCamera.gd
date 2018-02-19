extends KinematicBody

# class member variables go here, for example:
var linear_velocity = Vector3()
var gravity = Vector3()
var Target = Vector3()
var originalpos = Vector3()
var origin = Vector3()

func _ready():
	gravity = get_node("../../").gravity
	

func _process(delta):
	linear_velocity = move_and_slide(linear_velocity,-gravity.normalized())
	Target = get_node("../../target").translation
	origin = get_node("../../CameraOrigin").translation
	translation.x = clamp(translation.x, Target.x-1, Target.x+1)
	translation.y = clamp(translation.y, Target.y-1, Target.y+1)
	translation.z = clamp(translation.z, Target.z-1, Target.z+1)
	
	
	
	if translation != origin and not (is_on_floor() or is_on_ceiling() or is_on_wall()):
		
		if translation.x<origin.x:
			translation.x += delta*0.2
		else:
			translation.x -= delta*0.2

		if translation.y<origin.y:
			translation.y -= delta*0.2
		else:
			translation.y += delta*0.2

		if translation.z<origin.z:
			translation.z += delta*0.2
		else:
			translation.z -= delta*0.2
#func _fixed_process(delta):
	#move towards target destination
#	move(velocity*delta)
	
	#once target destination is reached
	#if(get_pos().distance_to(target) <= 20):
	#	#calculate new destination
	#	target.x = rand_range(xMin, xMax)		#set new random target destination
	#	var angle = get_angle_to(target)		#calc angle to target
	#	velocity.x = speed*sin(angle)			#convert linear speed into x and y components
	#	velocity.y = speed*cos(angle)