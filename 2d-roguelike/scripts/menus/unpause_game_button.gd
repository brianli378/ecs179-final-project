extends TextureButton

var _world:Node2D = World

func _pressed():
	print("unpausing game")
	get_tree().paused = false
	_world.unpause()
