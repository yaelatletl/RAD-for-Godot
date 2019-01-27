extends KinematicBody
class_name AI

##################  Constants ##################

const SENSES = preload("res://BaseGD/AI/3D_AI.tscn") 

enum {
IDLE = 0
SEARCH = 1
WALK = 2
RUN = 3
SHOOT = 4
ATTACK = 5
SPECIAL = 6
}

##################  Globals ##################  

var initialized = false 
var on_workstation = false
var workstation_near = false
var player_near = false
var is_on_sight = false
var path = [Vector3(0,0,0),Vector3(0,0,0)]
var m = SpatialMaterial.new()
var can_shoot = true
var current_target : Object

# Visualization Raycasts
var visible_obj1
var visible_obj2
var visible_obj3
var visible_obj4
var visible_obj5
var visible_obj6
var visible_obj7

################## Parameters ##################

# Behavioral
export(NodePath) var AstarPath = null
export(NodePath) var Navmesh = null 
export(bool) var AI_active = true
export(bool) var static_AI = false
export(int) var Team = 0
export(bool) var is_worker = false
export(int) var indifference = 10
export(bool) var walk_n_shoot = false
export(bool) var NavMeshMovement = true
export(bool) var DumbMovement = false
export(bool) var AstarMovement = false
export(float) var smellarea = 5
export(float) var heararea = 10
export(float) var health = 100
export(float) var speedfactor = 0.4
export(float) var hearing_precision = 2
export(float) var smelling_precision = 2
export(bool) var can_hear_workstations = true
export(bool) var can_smell_workstations = false
export(PackedScene) var gun = preload("res://BaseGD/Guns/Staff.tscn")
export(int) var timewaiting = 2


#Movement Values
export(bool) var flies = false
export(bool) var fixed_up = true
export(float) var weight = 1
export(float) var max_speed = 10
export(int) var turn_speed = 1
export(float) var accel = 19.0
export(float) var deaccel = 14.0
export(bool) var keep_jump_inertia = true
export(bool) var air_idle_deaccel = false
export(float) var JumpHeight = 7.0
export(float) var grav = 9.8
################## Signals ##################

signal viewing(array)
signal player_seen(player)
signal workstation_seen(Workstation)
signal AI_seen(AI)

################## Created ################## 

func update_values():
	$AI/Wait.wait_time = timewaiting
	$AI/Senses/SmellandHear/CollisionShape.shape.radius = smellarea
	$AI/Senses/Hear/CollisionShape.shape.radius = heararea
	
func get_visible():
	var vis = []
	vis.append(visible_obj1)
	for a in range(1,7):
		if get("visible_obj"+str(a)).get_collider() != null:
			vis.append(get("visible_obj"+str(a)).get_collider())
	emit_signal("viewing", vis)
	return vis

func _on_raycast(vis):
	for objects in vis:
		if objects is Player:
			emit_signal("player_seen", objects)
		elif objects is Workstation:
			emit_signal("workstation_seen", objects)
		elif objects is AI:
			emit_signal("AI_seen", objects)
func _on_AI_seen(AI):
	pass


##################  Built-ins ################## 
func _enter_tree():
	self.add_child(SENSES.instance())
	pass


func _ready():
	var AI = preload("res://addons/WorldManagement/3D_AI.tscn").instance()
	AI.translation += Vector3(0,1,0)
	add_child(AI)
	update_values()
	connect("viewing", self, "_on_raycast")
	connect("player_seen", self, "_on_player_seen")
	connect("AI_seen", self, "_on_AI_seen")
	connect("workstation_seen", self, "_on_workstation_seen")
	var groups = get_groups()
	visible_obj1 = $AI/Senses/SmellandHear/Eyes
	visible_obj2 = $AI/Senses/SmellandHear/Eyes/Eyes2
	visible_obj3 = $AI/Senses/SmellandHear/Eyes/Eyes3
	visible_obj4 = $AI/Senses/SmellandHear/Eyes/Eyes4
	visible_obj5 = $AI/Senses/SmellandHear/Eyes/Eyes5
	visible_obj6 = $AI/Senses/SmellandHear/Eyes/Eyes6
	visible_obj7 = $AI/Senses/SmellandHear/Eyes/Eyes7
	m.flags_unshaded = true
	m.flags_use_point_size = true
	m.albedo_color = Color(1.0, 1.0, 1.0, 1.0)
	#Spatial_Routine()
	#CHAR_SCALE = scale
	initialized = true
	current_target = null
	if not has_node("gun"):
		add_child(gun.instance())
	var astar = get_node(AstarPath).astar
	var NM = get_node(Navmesh)

func _process(delta):
	pass
	
func _exit_tree():
	pass