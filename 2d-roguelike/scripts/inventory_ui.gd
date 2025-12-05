extends Panel
class_name InventoryUI

@export var gun_manager_path: NodePath
@onready var gun_manager: GunManager = get_node(gun_manager_path) as GunManager
@onready var guns_container: GridContainer = $MarginContainer/GunsContainer
@onready var fusion_button: Button = get_node_or_null("FusionButton") as Button

var is_open: bool = false
var is_fusion_mode: bool = false
var first_selected_gun_key: String = ""
var second_selected_gun_key: String = ""
var gun_button_by_key: Dictionary = {}

func _ready() -> void:
	visible = false
	
	if fusion_button != null:
		fusion_button.text = "Fuse"
		fusion_button.pressed.connect(_on_fusion_button_pressed)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		_toggle_inventory()

func _toggle_inventory() -> void:
	is_open = not is_open
	visible = is_open
	if is_open:
		_refresh_guns()
	else:
		_exit_fusion_mode()


func _enter_fusion_mode() -> void:
	is_fusion_mode = true
	first_selected_gun_key = ""
	second_selected_gun_key = ""

	if fusion_button != null:
		fusion_button.text = "Cancel Fuse"
	_reset_button_visuals()


func _exit_fusion_mode() -> void:
	is_fusion_mode = false
	first_selected_gun_key = ""
	second_selected_gun_key = ""

	if fusion_button != null:
		fusion_button.text = "Fuse"
	_reset_button_visuals()


func _reset_button_visuals() -> void:
	for gun_key in gun_button_by_key.keys():
		var gun_button: Button = gun_button_by_key[gun_key]
		if gun_button != null:
			gun_button.button_pressed = false


func _refresh_guns() -> void:
	for child in guns_container.get_children():
		child.queue_free()

	gun_button_by_key.clear()

	if gun_manager == null:
		return

	var owned_gun_keys: Array[String] = gun_manager.get_owned_gun_keys()
	for gun_key in owned_gun_keys:
		var texture: Texture2D = gun_manager.get_gun_texture(gun_key)
		if texture == null:
			continue

		var gun_button := Button.new()
		gun_button.toggle_mode = is_fusion_mode
		gun_button.focus_mode = Control.FOCUS_NONE
		gun_button.icon = texture
		gun_button.expand_icon = true
		gun_button.custom_minimum_size = Vector2(150, 150)
		gun_button.pressed.connect(_on_gun_button_pressed.bind(gun_key, gun_button))
		guns_container.add_child(gun_button)
		gun_button_by_key[gun_key] = gun_button


func _on_fusion_button_pressed() -> void:
	if not is_open:
		_toggle_inventory()
	if is_fusion_mode:
		_exit_fusion_mode()
	else:
		_enter_fusion_mode()


func _on_gun_button_pressed(gun_key: String, gun_button: Button) -> void:
	if not is_fusion_mode:
		gun_button.button_pressed = false
		return

	if first_selected_gun_key == "":
		first_selected_gun_key = gun_key
		gun_button.button_pressed = true
		return

	if gun_key == first_selected_gun_key and second_selected_gun_key == "":
		first_selected_gun_key = ""
		gun_button.button_pressed = false
		return

	second_selected_gun_key = gun_key
	gun_button.button_pressed = true
	_attempt_fusion()


func _attempt_fusion() -> void:
	if first_selected_gun_key == "" or second_selected_gun_key == "":
		return
	var fusion_result_key: String = gun_manager.fuse_guns(first_selected_gun_key, second_selected_gun_key)
	if fusion_result_key == "":
		print("cannot fuse ", first_selected_gun_key, " + ", second_selected_gun_key)
	else:
		print("successfully fused ", first_selected_gun_key, " + ", second_selected_gun_key, " = ", fusion_result_key)

	_exit_fusion_mode()
	_refresh_guns()
