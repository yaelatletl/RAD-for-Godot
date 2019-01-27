extends Area
class_name Workstation
var functional = true
var final_pos = Vector3(0,0,0)
var health = 0 
func _ready():
	final_pos = $FinalPos.translation
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
