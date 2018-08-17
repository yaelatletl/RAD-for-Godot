extends KinematicBody

export(float) var Smelling_radio = 1

func _ready():
	$Area/CollisionShape.shape.radius = Smelling_radio
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
