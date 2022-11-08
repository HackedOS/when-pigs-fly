class_name Enemy
extends KinematicBody

""" Signals """
signal deal_damage(damageAmmount)

""" Node References """
onready var _collider := get_node("CollisionShape")
onready var _player := get_parent().get_node("Player")
onready var _path := get_node("Node")

""""" Mevement variables """
export var _chaseSpeed = 40
onready var _targetWaypoint: Vector3 = _path._patrolPoints[0]
var _moveDirection: Vector3 = Vector3.ZERO
export var patrolSpeed: float = 40
var currentWaypoint: int = 0

""" Combat Variables """
export var _detectRadius: float = 5
export var _chaseAreaRadius: float = 5
export var _attackRange: float = 1
export var _damage: float = 5
var IsDead: bool = false
var PlayerDetected: bool = false

enum EnemyState {
	Idle,
	Chasing,
	Attacking,
}

var state = EnemyState.Idle

func _process(delta):
	_CheckForPlayer()

func _physics_process(delta):
	match state:
			EnemyState.Idle:
				_Idling(delta)
			EnemyState.Chasing:
				_Chasing(delta)
			EnemyState.Attacking:
				_Attack()

func _Idling(delta):
	if PlayerDetected == false:
		_moveDirection = (_targetWaypoint - translation).normalized()
		
		if translation.distance_to(_targetWaypoint) > 0.1:
			move_and_slide(_moveDirection * patrolSpeed * delta)
		else:
			_path._WaitFor(delta, 2)
			
			if _path.timerEnded == true:
				_path.timerEnded = false
				currentWaypoint += 1
				currentWaypoint %= _path._patrolPoints.size()
				_targetWaypoint = _path._patrolPoints[currentWaypoint]
	
func _CheckForPlayer():
	if PlayerDetected == false:
		if translation.distance_to(_player.translation) <= _detectRadius:
			PlayerDetected = true
			state = EnemyState.Chasing
	else:
		if translation.distance_to(_player.translation) <= _attackRange:
			state = EnemyState.Attacking
	
func _Chasing(delta):
	if translation.distance_to(_player.translation) < _chaseAreaRadius:
		_targetWaypoint = _player.translation
		_moveDirection = (_player.translation - translation).normalized()
		move_and_slide(_moveDirection * _chaseSpeed * delta)
	else:
		PlayerDetected = false
		_targetWaypoint = _path._patrolPoints[currentWaypoint]
		state = EnemyState.Idle

func _Attack():
	emit_signal("deal_damage", _damage)
