class_name Player
extends KinematicBody2D

export var velocity_mult = 300.0

# Get reference to gameplay area (for navigation purposes)
export var play_area_path : NodePath = "PlayArea"
onready var _play_area = get_node(play_area_path) as PlayArea

onready var _upper_limit_point = get_node("UpperLimitPoint")
onready var _lower_limit_point = get_node("LowerLimitPoint")

func _ready():
	if _play_area == null:
		push_warning("Player has no reference to play area. Out of bounds navigation is possible.")


var velocity = Vector2.ZERO
func _physics_process(_delta):
	
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = velocity * velocity_mult
	var _unused = move_and_slide(velocity)
	
	if _play_area:
		
		# Apply upper limit
		# Clamp the global pos of the upper limit point so it stays below "ceiling"
		# Then, set the player at this position, plus an offset relative to that collision point
		# Remember that top of the screen => y = 0, which is why we use min and not max
		position.y = clamp(_upper_limit_point.global_position.y, _play_area.get_ceiling_min_y(), _play_area.height_scaled) - _upper_limit_point.position.y
		
		# Apply lower limit (bottom of screen)
		position.y = clamp(_lower_limit_point.global_position.y, 0, _play_area.height_scaled) - _lower_limit_point.position.y
