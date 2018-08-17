extends Area

export(float) var damage = 10
export(float) var speed = 10
export(bool) var follows = false
export(bool) var smart = false

#export(AnimatedSprite) var MainSprite = null
onready var Mask = preload("res://BaseGD/Bullets/Mark.tscn")
var destination = Vector3(0,0,0)
var target = null

func normal_movement():
	if is_colliding ():
		var normal = $WallCheck.get_collision_normal()
		Mask.instance().look_at(normal)
	if follows and target != null:
		#If you use the follows variable you must also set the target or else it will fail
		destination = target.translation
	translation =+ (destination-translation).normalized()*speed

func smart_movement():
	pass







func _process(delta):
	if smart:
		smart_movement()
	else:
		normal_movement()
	






func _on_EnergyBullet_body_entered(body):
	body.health =- damage
	pass
func _on_MetalBullet_body_entered(body):
	pass
func _on_SplashBullet_body_entered(body):
	pass