extends Node
func map(x, in_min, in_max, out_min, out_max):
	return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
#Usage:  val = map(val, 0, 1023, 0, 255)

func rotation_from_to(A,B):
	var output=Vector3()
	output.x=rad2deg(atan2((B.y-A.y),(B.z-A.z)))
	output.y=rad2deg(atan2((B.z-A.z),(B.x-A.x)))
	output.z=rad2deg(atan2((B.y-A.y),(B.x-A.x)))
	return output
#Returns a Vector3 containing cilindircal relative coordinates.
#Both Coordinates must be the same type (either local or global)