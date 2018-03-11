extends Camera
var cam

var PCL = Vector3()
var framewidth = 0.0
var xform = get_camera_transform().basis
func _ready():
	var originalrotation = rotation_degrees

func _process(delta):
	cam = get_node("../../../Player").translationcamera
	var portal = (get_node("../../../Portal").translation)
	var portalrotation = get_node("../../MeshInstance").rotation_degrees
	var VCL = cam-portal
	var sip =  cam.distance_to(portal) #( portalrotation-RAD.rotation_from_to(portal, cam)).normalized()
	#sip.x = clamp(sip.x,0,360)
	#sip.y = clamp(sip.y,0,360)
	fov =  RAD.map(sip,0,100,90,180) #100*sqrt(sip.x*sip.x+sip.y*sip.y)+90
	print(fov)
	print(sip)
	framewidth = 100 #get_node("../../MeshInstance").scale.x
	PCL = (get_node("../../MeshInstance").translation)
	
	#rotation_degrees.x = Math.map(rot.x, -360, 360, rotation_degrees.x-90, rotation_degrees.x+90)
	#rotation_degrees.y = Math.map(rot.y, -360, 360, rotation_degrees.y-90, rotation_degrees.y+90)
	
	var Scale = (VCL.dot(Vector3(0,0,portal.z))*(rad2deg(tan(deg2rad(fov/2)))))/(framewidth/2)
	h_offset = (VCL.dot(Vector3(portal.x,0,0))*Scale)/framewidth
	v_offset = (VCL.dot(Vector3(0,portal.y,0))*Scale)/framewidth
