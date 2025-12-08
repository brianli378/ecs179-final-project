extends TextureButton

var _world:Node2D = World

func _pressed():
	print("keybinds screen")
	_world.fusion_tutorial()
