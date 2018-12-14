extends MeshInstance
const noice = preload("res://assets/Shaders/Noice.tres")
var og_mat = null
var og_mat2 = null
export(bool) var has2ndmat = false
var teleport_state = false
var time 


func _ready():
	og_mat = get_surface_material(0)
	if has2ndmat:
		og_mat2 = get_surface_material(1)
	time = Timer.new()
	time.time = 2
	time.one_shot = true
	time.connect(self, "timeout", "teleport")
	add_child(time)
	
	
func teleport():
	if not teleport_state:
		teleport_state = true
		time.start()
		teleport_effect()
	else:
		teleport_state = false
		remove_effects()
		
func teleport_effect():
	set_surface_material(0, noice)
	if has2ndmat:
		og_mat2 = set_surface_material(1, noice)
		
		
func remove_effects():
	set_surface_material(0, og_mat)
	if has2ndmat:
		og_mat2 = set_surface_material(1, og_mat2)