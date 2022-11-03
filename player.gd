extends KinematicBody2D

var velocity = Vector2.ZERO
func _physics_process(delta):
	
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = velocity * 100
	move_and_slide(velocity)
