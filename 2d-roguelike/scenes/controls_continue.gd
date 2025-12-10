extends TextureButton

var _world:Node2D = World

func _pressed():
	print("starting game")
	_world.start_game()
