extends TextureButton

var _world:Node2D = World

func _pressed():
	_world.controls_menu()
