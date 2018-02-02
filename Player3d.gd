extends KinematicBody

#Signals
signal hit
signal shooting
signal dead
signal HasObjective
signal paused
signal reload_weapon

#Just ignore this variables. They are used for camera.
var yaw = 0
var pitch = 0
var cameraaim = Vector3()

#Change this stuff
export (int) var WALKSPEED
export (int) var RUNSPEED
export (PackedScene) var Playermodel
export (Vector3) var worldsize #This should be a 3d area that delmits the space of the scene
export(bool) var active=true
export(float) var view_sensitivity = 0.3

##Physics
export(float) var ACCEL= 2

func _ready():
  set_process_input(true)
  set_process(true)
  Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
  

  #get_node("Crosshair").set_crosshair(1)

##Ported from eco-controller, may not work.
func _input(ev):

	if not active:
		return

	if (ev is InputEventMouseMotion):
		yaw = yaw - ev.relative.x * view_sensitivity
		pitch = clamp(pitch - ev.relative.y * view_sensitivity,-4500,4500)
		$Camera.rotation_degrees = Vector3(deg2rad(pitch), deg2rad(yaw), 0)

#We're not gonna use this just yet.
	#if ie.type == InputEvent.KEY:
		#if Input.is_action_pressed("action_use"):
			#var ray=node_action_ray
			#if ray.is_colliding():
				#var obj=ray.get_collider()
				#if obj.has_method("use"):
					#obj.use(self)
	#	if Input.is_action_pressed("action_reload"):
		#	weapon_base.reload()
			#attack_timeout=player_data.reload_time
			#emit_signal("reload_weapon")
		#if Input.is_action_pressed("ui_toggle_crouch"):
			#if body_position=="crouch":
				#stand()
				#body_position="stand"
			#else:
				#crouch()
				#body_position="crouch"
##End of the copypasta
var velocity = Vector3()


func _process(delta):
	var aim = $Camera.get_camera_transform().basis
	var direction = Vector3()
	if Input.is_action_pressed("move_forwards"):
		direction -= aim[2]
	if Input.is_action_pressed("move_backwards"):
		direction += aim[2]
	if Input.is_action_pressed("move_left"):
    	direction -= aim[0]
	if Input.is_action_pressed("move_right"):
    	direction += aim[0]
	direction = direction.normalized()
	var target = direction*WALKSPEED

	velocity = Vector3().linear_interpolate(target,ACCEL*delta)

	translation += velocity * delta

	translation.x = clamp(translation.x, 0, 50)
	translation.y = clamp(translation.y, 0, 0)
	translation.z = clamp(translation.z, 0, 100)
