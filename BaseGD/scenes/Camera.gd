extends Camera
var cam

var PCL = Vector3()
var framewidth = 0.0
var xform = get_camera_transform().basis[2]
var originalrotation
export(NodePath) var PortalOut
func _ready():
	originalrotation = rotation_degrees

func _process(delta):
	#rotation_degrees = Vector3(0.2*(get_node("../../../Player").aimrotation.x-xform.x),originalrotation.y,0)
	cam = get_node("../../../Player").translationcamera
	var portal = (get_node("../../../Portal").translation)
	var portalrotation = get_node("../../MeshInstance").rotation_degrees
	var VCL = cam-portal
	var sip = VCL #cam.distance_to(portal) #( portalrotation-RAD.rotation_from_to(portal, cam))#.normalized() 
	
	fov =  sqrt(sip.x*sip.x+sip.y*sip.y)+90 #RAD.map(sip,0,100,90,180) #180 - (180 - 85)*exp(-0.1*sip) # #
	framewidth = 200 #get_node("../../MeshInstance").scale.x
	PCL = (get_node("../../MeshInstance").translation)
	
	#rotation_degrees.x = Math.map(rot.x, -360, 360, rotation_degrees.x-90, rotation_degrees.x+90)
	#rotation_degrees.y = Math.map(rot.y, -360, 360, rotation_degrees.y-90, rotation_degrees.y+90)
	
	var Scale = (VCL.dot(Vector3(0,0,portal.z))*(rad2deg(tan(deg2rad(fov/2.0)))))/(framewidth/2.0)
	h_offset = (VCL.dot(Vector3(portal.x,0,0))*Scale)/framewidth
	v_offset = (VCL.dot(Vector3(0,portal.y,0))*Scale)/framewidth
