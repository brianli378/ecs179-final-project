extends Panel
class_name InventoryUI

@export var gun_manager_path: NodePath
@onready var gun_manager: GunManager = get_node(gun_manager_path) as GunManager
@onready var guns_container: GridContainer = $MarginContainer/GunsContainer

var is_open: bool = false

func _ready() -> void:
	visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		_toggle_inventory()

func _toggle_inventory() -> void:
	is_open = not is_open
	visible = is_open
	if is_open:
		_refresh_guns()

func _refresh_guns() -> void:
	for child in guns_container.get_children():
		child.queue_free()

	if gun_manager == null:
		return

	var keys: Array = gun_manager.get_owned_gun_keys()
	for gun_key in keys:
		var texture: Texture2D = gun_manager.get_gun_texture(gun_key)
		if texture == null:
			continue

		var icon := TextureRect.new()
		icon.texture = texture
		icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		icon.ignore_texture_size = true
		icon.custom_minimum_size = Vector2(150, 150)
		guns_container.add_child(icon)
