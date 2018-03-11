extends Spatial
export(NodePath) var Out 
var materialin
var materialout

func _ready():
	var origin=$Renderer/Viewport/Camera.get_camera_transform().origin
	materialin = get_node(Out).materialout
	materialout = $MeshInstance.get_surface_material(0)
	#$MeshInstance.set_surface_material(0, materialin)
	var far = $Renderer/Viewport/Camera.far
	

#func _process(delta):

