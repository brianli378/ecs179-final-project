extends MarginContainer

@export var scroll_speed = 50.0
@export var background_set: int = 1

var parallax_layers = []

func _ready():
	# reference to each layer of the images
	parallax_layers = [
		$Parallax2D,
		$Parallax2D2,
		$Parallax2D3,
		$Parallax2D4,
		$Parallax2D5
	]
	
	load_background_theme(background_set)


func load_background_theme(set_number: int):
	var base_path = "res://assets/craftpix-net-832833-free-scrolling-city-backgrounds-pixel-art/1 Backgrounds/%d/Night/" % set_number
	
	# in each layer of the image
	for i in range(5):
		var layer_num = i + 1
		var texture_path = base_path + "%d.png" % layer_num
		var sprite = parallax_layers[i].get_child(0) as Sprite2D
		if sprite:
			sprite.texture = load(texture_path)
			sprite.centered = false
			sprite.visible = true
			
			# scale to godot 1080 x 720 p resolution
			var texture_size = sprite.texture.get_size()
			var scale_x = 1080.0 / texture_size.x
			var scale_y = 720.0 / texture_size.y
			sprite.scale = Vector2(max(scale_x, scale_y), max(scale_x, scale_y))

func _process(delta):
	if parallax_layers.is_empty():  
		return
	
	# speeds for each layer, from back to foreground
	var speeds = [0.05, 0.2, 0.4, 0.7, 2.0]
	
	for i in range(parallax_layers.size()):
		var layer = parallax_layers[i]
		layer.scroll_offset.x -= scroll_speed * speeds[i] * delta
		
		if layer.scroll_offset.x <= -1280:
			layer.scroll_offset.x += 1280
