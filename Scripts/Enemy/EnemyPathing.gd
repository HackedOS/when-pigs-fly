extends Node

export var pointsDistanceFromEnemy = 2
var _patrolPoints = []

var _timer: float = 0
var timerEnded: bool = false
var routeCreated: bool = false

func CreatePatrolRoute():
	_patrolPoints.append(
		Vector3(rand_range(get_parent().global_translation.x - pointsDistanceFromEnemy, get_parent().global_translation.x), 
		get_parent().global_translation.y, get_parent().global_translation.z))
		
	_patrolPoints.append(
		Vector3(rand_range(get_parent().global_translation.x, get_parent().global_translation.x + pointsDistanceFromEnemy), 
		get_parent().global_translation.y, get_parent().global_translation.z))
	routeCreated = true
	
func WaitFor(delta: float, cooldownTime: float) -> void:
	if timerEnded == false:
		_timer += delta
		
		if _timer >= cooldownTime:
			_timer = 0
			timerEnded = true
