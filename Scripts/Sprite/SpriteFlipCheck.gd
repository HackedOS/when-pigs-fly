extends Sprite3D

var _directionVector: Vector3

func _process(delta):
	_directionVector = get_parent()._moveDirection
	
	if _directionVector.x < 0:
		flip_h = true
	else:
		flip_h = false
