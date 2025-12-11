## source for some code: https://www.makeuseof.com/godot-raycast2d-nodes-line-of-sight-detection/
class_name EnemyLineOfSight
extends RayCast2D

var seeing_player: bool = false

var _target: Player = null

func _ready() -> void: 
	_target = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if _target == null:
		return
	target_position = to_local(_target.global_position)
	if is_colliding():
		var collided_object : Node = get_collider()
		if collided_object is Player:
			seeing_player = true
		else:
			seeing_player = false
