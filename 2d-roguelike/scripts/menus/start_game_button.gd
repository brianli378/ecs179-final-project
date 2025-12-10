extends TextureButton

var _world:Node2D = World

func _pressed():
	print("start game")
	_world.start_game()
