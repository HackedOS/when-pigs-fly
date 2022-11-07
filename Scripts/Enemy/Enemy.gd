class_name Enemy
extends KinematicBody

""" Signals """
signal take_damage

""" Node References """
onready var _collider := get_node("CollisionShape")
onready var _player := get_parent().get_node("Player")
onready var _path := get_node("Path")

""""" Mevement variables """
export var _moveSpeed = 2.2
onready var _targetWaypoint: Vector3 = _path._patrolPoints[0]
var _moveDirection: Vector3 = Vector3.ZERO
export var patrolSpeed: float = 2

""" Combat Variables """
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
	#print(state)
	# Basic enemy bahaviour state machine for registering main actions
	match state:
			EnemyState.Idle:
				#print("Enemy is Idle")
				_Idling(delta)
			EnemyState.Chasing:
				pass
			EnemyState.Attacking:
				pass

func _physics_process(delta):
	if state == EnemyState.Chasing:
		_moveDirection = (_player.translation - translation).normalized()
		var collision = move_and_collide(_moveDirection * _moveSpeed * delta, false)
		
		if collision:
			state = EnemyState.Attacking
			 
func _Idling(delta):
	if PlayerDetected == false:
		_moveDirection = (_targetWaypoint - translation).normalized()
		
		if _targetWaypoint.x != translation.x:
			move_and_collide(_moveDirection * patrolSpeed * delta, false)
		else:
			print("Arrived")
			
	
