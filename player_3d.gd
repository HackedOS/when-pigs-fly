extends KinematicBody

var velocity = Vector3.ZERO
func _physics_process(_delta):
	
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.z = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	velocity.z *= 10.0
	velocity.x *= 5.0
	
	print(velocity)
	var _unused = move_and_slide(velocity)
