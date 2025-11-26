extends Sprite2D

var pistol_texture = preload("res://assets/pistol_sprite.png")
var shotgun_texture = preload("res://assets/shotgun_sprite.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Gun sprite ready! Current texture: ", texture)

func switch_gun(gun_type: String):
	match gun_type:
		"pistol":
			texture = pistol_texture
		"rifle":
			#TODO: add rifle texture
			texture = pistol_texture
		"shotgun":
			texture = shotgun_texture
