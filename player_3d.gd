extends KinematicBody

## Velocity multiplier for directions
## Note that because of camera setup, using the same number results
## in different visual results for x and z axis, so it's best to set them separately
export(float, 1.0, 10.0) var _vel_horiz_mult = 5.0
export(float, 1.0, 20.0) var _vel_z_mult = 10.0

var velocity = Vector3.ZERO
func _physics_process(_delta):
	
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.z = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	velocity.x *= _vel_horiz_mult
	velocity.z *= _vel_z_mult
	
	var _unused = move_and_slide(velocity)
