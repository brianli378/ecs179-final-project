extends TextureButton

var _world:Node2D = World

var _recheck_pause:float = 0.0

var _curr_time:float = 0.0

var _check_delta:float = 1

#func _process(delta: float) -> void:
	#_curr_time += delta
	
	#if _curr_time > _recheck_pause and get_tree().paused and Input.is_action_just_pressed("pause"):
	#	_pressed()
	#	_recheck_pause = _curr_time + _check_delta

func _pressed():
	print("unpausing game")
	get_tree().paused = false
	_world.unpause()
