extends Path

export var pointsDistanceFromEnemy = 2
var _patrolPoints = []

var _timer: float = 0
var timerEnded: bool = false

func _ready():
	_patrolPoints.append(
		Vector3(rand_range(get_parent().global_translation.x - pointsDistanceFromEnemy, get_parent().global_translation.x), 
		get_parent().global_translation.y, get_parent().global_translation.z))
		
	_patrolPoints.append(
		Vector3(rand_range(get_parent().global_translation.x, get_parent().global_translation.x + pointsDistanceFromEnemy), 
		get_parent().global_translation.y, get_parent().global_translation.z))
		
func _WaitFor(delta: float, cooldownTime: float) -> void:
	if timerEnded == false:
		_timer += delta
		
		if _timer >= cooldownTime:
			_timer = 0
			timerEnded = true
