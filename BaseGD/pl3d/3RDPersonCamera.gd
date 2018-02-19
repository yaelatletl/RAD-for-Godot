extends KinematicBody

# class member variables go here, for example:
var linear_velocity = Vector3()
var gravity = Vector3()
var Target = Vector3()
var originalpos = Vector3()
var origin = Vector3()
var cameramovement
func _ready():
	gravity = get_node("../../").gravity
	cameramovement = get_node("../../").fixpos

func _process(delta):
	linear_velocity = move_and_slide(linear_velocity,-gravity.normalized())
	Target = get_node("../../target").translation
	origin = get_node("../../CameraOrigin")
	translation.x = clamp(translation.x, Target.x-5, Target.x+5)
	translation.y = clamp(translation.y, Target.y-5, Target.y+5)
	translation.z = clamp(translation.z, Target.z-5, Target.z+5)
	
	
	
	if translation != origin.translation and not (is_on_floor() or is_on_ceiling() or is_on_wall()):
		#Vector maths to get the [cof] camera to it's place each time it moves
		translation = translation + delta*(origin.translation-translation).normalized()
	#	if translation.x<origin.x:
	#		translation.x += delta*0.2
	#	else:
	#		translation.x -= delta*0.2

	#	if translation.y<origin.y:
	#		translation.y -= delta*0.2
	#	else:
	#		translation.y += delta*0.2

		#if translation.z<origin.z:
		#	translation.z += delta*0.2
	#	else:
	#		translation.z -= delta*0.2
		#var dir = (origin.transform.origin - transform.origin).normalized()
		#translation = dir*delta