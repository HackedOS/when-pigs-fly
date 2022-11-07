extends Path

export var pointsDistanceFromEnemy = 2
var _patrolPoints = []

func _ready():
	_patrolPoints.append(
		Vector3(rand_range(get_parent().global_translation.x - pointsDistanceFromEnemy, get_parent().global_translation.x), 
		get_parent().global_translation.y, get_parent().global_translation.z))
		
	_patrolPoints.append(
		Vector3(rand_range(get_parent().global_translation.x, get_parent().global_translation.x + pointsDistanceFromEnemy), 
		get_parent().global_translation.y, get_parent().global_translation.z))
		
