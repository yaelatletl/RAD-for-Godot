extends Camera

# class member variables go here, for example:
# var a = 2
var yaw = 0.0
var pitch = 0.0
var view_sensitivity 
func _ready():
	set_process_input(true)


func _input(ev):
	view_sensitivity = get_node("..").view_sensitivity
	if (ev is InputEventMouseMotion):
		yaw = yaw - ev.relative.x * view_sensitivity
		pitch = clamp(pitch - ev.relative.y * view_sensitivity,-90,90)
		rotation_degrees = Vector3(pitch, yaw, 0)