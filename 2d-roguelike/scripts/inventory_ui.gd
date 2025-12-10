extends Panel
class_name InventoryUI

@export var gun_manager_path: NodePath
@onready var gun_manager: GunManager = get_node(gun_manager_path) as GunManager
@onready var guns_container: GridContainer = $MarginContainer/GunsContainer
@onready var fusion_button: Button = get_node_or_null("FusionButton") as Button

var is_open: bool = false
var gun_button_by_key: Dictionary = {}
var gun_box_by_key: Dictionary = {}

# fusion slots
var fusion_slot_1: Panel = null
var fusion_slot_2: Panel = null
var fusion_result_display: Button = null
var finalize_button: Button = null

# info labels
var slot_1_info_label: Label = null
var slot_2_info_label: Label = null
var result_name_label: Label = null

# empty labels for fusion slots
var fusion_slot_1_gun: String = ""
var fusion_slot_2_gun: String = ""
var fusion_preview_result: String = ""

# color scheme
var cyan_color = Color(0, 1, 1, 1)  # Cyan
var red_color = Color(1, 0, 0, 1)
var white_color = Color(1, 1, 1, 1)  # White

func _ready() -> void:
	visible = false
	# so gun_manager can see
	add_to_group("inventory")
	_create_fusion_ui()
	
	if fusion_button != null:
		fusion_button.queue_free()

func _process(_delta: float) -> void:
	# rebound to i and b
	if Input.is_action_just_pressed("inventory"):
		_toggle_inventory()

func _toggle_inventory() -> void:
	is_open = not is_open
	visible = is_open
	if is_open:
		_refresh_guns()

func _create_fusion_ui() -> void:
	# get margin container
	var margin_container = $MarginContainer
	
	# vbox to hold everything
	var main_vbox = VBoxContainer.new()
	main_vbox.add_theme_constant_override("separation", 20)
	
	# spacing at the top
	var top_spacer = Control.new()
	top_spacer.custom_minimum_size = Vector2(0, 20)
	main_vbox.add_child(top_spacer)
	
	# centering of the guns
	var guns_center_container = CenterContainer.new()
	guns_container.get_parent().remove_child(guns_container)
	guns_center_container.add_child(guns_container)
	main_vbox.add_child(guns_center_container)
	
	# add a cyan seperator
	var separator = HSeparator.new()
	var separator_style = StyleBoxFlat.new()
	separator_style.bg_color = cyan_color
	separator.add_theme_stylebox_override("separator", separator_style)
	main_vbox.add_child(separator)
	
	# creating box for fusion and result
	var fusion_hbox = HBoxContainer.new()
	fusion_hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	fusion_hbox.add_theme_constant_override("separation", 30)
	
	# label for fusion guns
	var slot_1_vbox = VBoxContainer.new()
	slot_1_vbox.add_theme_constant_override("separation", 5)
	
	# firing style label
	var slot_1_title = Label.new()
	slot_1_title.text = "Firing Style"
	slot_1_title.add_theme_color_override("font_color", cyan_color)
	slot_1_title.add_theme_font_size_override("font_size", 14)
	slot_1_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	slot_1_vbox.add_child(slot_1_title)
	
	fusion_slot_1 = _create_fusion_slot()
	slot_1_vbox.add_child(fusion_slot_1)
	
	slot_1_info_label = Label.new()
	slot_1_info_label.text = ""
	slot_1_info_label.add_theme_color_override("font_color", cyan_color)
	slot_1_info_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	slot_1_vbox.add_child(slot_1_info_label)
	fusion_hbox.add_child(slot_1_vbox)
	
	# + label for fusion
	var plus_label = Label.new()
	plus_label.text = "+"
	plus_label.add_theme_color_override("font_color", cyan_color)
	plus_label.add_theme_font_size_override("font_size", 48)
	plus_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	fusion_hbox.add_child(plus_label)
	
	# second fusion box with labels
	var slot_2_vbox = VBoxContainer.new()
	slot_2_vbox.add_theme_constant_override("separation", 5)
	
	# projectile type label for slot 2
	var slot_2_title = Label.new()
	slot_2_title.text = "Projectile Type"
	slot_2_title.add_theme_color_override("font_color", cyan_color)
	slot_2_title.add_theme_font_size_override("font_size", 14)
	slot_2_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	slot_2_vbox.add_child(slot_2_title)
	
	fusion_slot_2 = _create_fusion_slot()
	slot_2_vbox.add_child(fusion_slot_2)
	
	slot_2_info_label = Label.new()
	slot_2_info_label.text = ""
	slot_2_info_label.add_theme_color_override("font_color", cyan_color)
	slot_2_info_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	slot_2_vbox.add_child(slot_2_info_label)
	fusion_hbox.add_child(slot_2_vbox)
	
	# '=' sign label
	var equals_label = Label.new()
	equals_label.text = "="
	equals_label.add_theme_color_override("font_color", cyan_color)
	equals_label.add_theme_font_size_override("font_size", 48)
	equals_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	fusion_hbox.add_child(equals_label)
	
	# fusion result vbox
	var result_vbox = VBoxContainer.new()
	result_vbox.add_theme_constant_override("separation", 5)
	
	# fusion result label
	var result_title = Label.new()
	result_title.text = "Result"
	result_title.add_theme_color_override("font_color", cyan_color)
	result_title.add_theme_font_size_override("font_size", 14)
	result_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	result_vbox.add_child(result_title)
	
	# result display creation
	var result_panel = Panel.new()
	var result_style = StyleBoxFlat.new()
	result_style.bg_color = Color(0.2, 0.2, 0.3, 1)
	result_style.border_width_left = 3
	result_style.border_width_top = 3
	result_style.border_width_right = 3
	result_style.border_width_bottom = 3
	result_style.border_color = cyan_color  # cyan border
	result_panel.add_theme_stylebox_override("panel", result_style)
	result_panel.custom_minimum_size = Vector2(150, 150)
	
	var result_button := Button.new()
	result_button.name = "ResultDisplay"
	result_button.focus_mode = Control.FOCUS_NONE
	result_button.expand_icon = true
	result_button.set_anchors_preset(Control.PRESET_FULL_RECT)
	result_button.flat = true
	result_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	result_panel.add_child(result_button)
	fusion_result_display = result_button
	
	result_vbox.add_child(result_panel)
	
	# add result name label
	result_name_label = Label.new()
	result_name_label.text = ""
	result_name_label.add_theme_color_override("font_color", cyan_color)
	result_name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	result_vbox.add_child(result_name_label)
	
	fusion_hbox.add_child(result_vbox)
	
	# center the fusion area
	var fusion_center_container = CenterContainer.new()
	fusion_center_container.add_child(fusion_hbox)
	main_vbox.add_child(fusion_center_container)
	
	# finalize button creation
	var button_container = CenterContainer.new()
	finalize_button = Button.new()
	finalize_button.text = "Finalize Fusion"
	finalize_button.add_theme_color_override("font_color", cyan_color)
	finalize_button.add_theme_color_override("font_disabled_color", Color(0.3, 0.5, 0.5, 1))  # darker cyan when disabled
	finalize_button.custom_minimum_size = Vector2(200, 50)
	finalize_button.disabled = true
	finalize_button.pressed.connect(_on_finalize_fusion)
	button_container.add_child(finalize_button)
	main_vbox.add_child(button_container)
	
	# add main vbox to margin container
	margin_container.add_child(main_vbox)

func _create_fusion_slot() -> Panel:
	# create a container with a cyan border
	var gun_box := Panel.new()
	var box_style := StyleBoxFlat.new()
	box_style.bg_color = Color(0.2, 0.2, 0.2, 1)
	box_style.border_width_left = 3
	box_style.border_width_top = 3
	box_style.border_width_right = 3
	box_style.border_width_bottom = 3
	box_style.border_color = cyan_color  # Cyan border
	gun_box.add_theme_stylebox_override("panel", box_style)
	gun_box.custom_minimum_size = Vector2(150, 150)
	
	# create a button with gun icon
	var gun_button := Button.new()
	gun_button.name = "GunDisplay"
	gun_button.focus_mode = Control.FOCUS_NONE
	gun_button.expand_icon = true
	gun_button.set_anchors_preset(Control.PRESET_FULL_RECT)
	gun_button.flat = true
	gun_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	gun_box.add_child(gun_button)
	
	return gun_box

func _refresh_guns() -> void:
	# refreshing guns when selected/unselected
	for child in guns_container.get_children():
		child.queue_free()
	gun_button_by_key.clear()
	gun_box_by_key.clear()
	
	if gun_manager == null:
		return
	
	var owned_gun_keys: Array[String] = gun_manager.get_owned_gun_keys()
	for gun_key in owned_gun_keys:
		var texture: Texture2D = gun_manager.get_gun_texture(gun_key)
		if texture == null:
			continue
		
		# create a container with cyan border
		var gun_box := Panel.new()
		var box_style := StyleBoxFlat.new()
		box_style.bg_color = Color(0.15, 0.15, 0.2, 1)
		box_style.border_width_left = 2
		box_style.border_width_top = 2
		box_style.border_width_right = 2
		box_style.border_width_bottom = 2
		if (owned_gun_keys.size() - owned_gun_keys.find(gun_key)) >= 5:
			box_style.border_color = red_color
		else:
			box_style.border_color = cyan_color  # Cyan border
		gun_box.add_theme_stylebox_override("panel", box_style)
		gun_box.custom_minimum_size = Vector2(150, 150)
		
		var gun_button := Button.new()
		gun_button.focus_mode = Control.FOCUS_NONE
		gun_button.icon = texture
		gun_button.expand_icon = true
		gun_button.set_anchors_preset(Control.PRESET_FULL_RECT)
		gun_button.flat = true
		gun_button.pressed.connect(_on_gun_button_pressed.bind(gun_key))
		
		gun_box.add_child(gun_button)
		guns_container.add_child(gun_box)
		gun_button_by_key[gun_key] = gun_button
		gun_box_by_key[gun_key] = gun_box

func _clear_fusion_slot(slot: Panel) -> void:
	# clear fusion slot when unselected
	var gun_button = slot.get_node("GunDisplay") as Button
	if gun_button != null:
		gun_button.icon = null

func _on_gun_button_pressed(gun_key: String) -> void:
	print("Gun button pressed: ", gun_key)
	
	# check if gun is already selected
	if fusion_slot_1_gun == gun_key:
		fusion_slot_1_gun = ""
		_clear_fusion_slot(fusion_slot_1)
		_update_gun_box_highlight(gun_key, false)
		_update_fusion_info_labels()
		_check_fusion_preview()
		return
	
	if fusion_slot_2_gun == gun_key:
		fusion_slot_2_gun = ""
		_clear_fusion_slot(fusion_slot_2)
		_update_gun_box_highlight(gun_key, false)
		_update_fusion_info_labels()
		_check_fusion_preview()
		return
	
	# put gun in first fusion slot
	if fusion_slot_1_gun == "":
		fusion_slot_1_gun = gun_key
		_update_fusion_slot(fusion_slot_1, gun_key)
		_update_gun_box_highlight(gun_key, true)
		_update_fusion_info_labels()
	elif fusion_slot_2_gun == "":
		fusion_slot_2_gun = gun_key
		_update_fusion_slot(fusion_slot_2, gun_key)
		_update_gun_box_highlight(gun_key, true)
		_update_fusion_info_labels()
	else:
		# both slots full, replace first one
		_update_gun_box_highlight(fusion_slot_1_gun, false)
		fusion_slot_1_gun = gun_key
		_update_fusion_slot(fusion_slot_1, gun_key)
		_update_gun_box_highlight(gun_key, true)
		_update_fusion_info_labels()
	
	_check_fusion_preview()

func _update_fusion_slot(slot: Panel, gun_key: String) -> void:
	# update fusion slot
	var gun_button = slot.get_node("GunDisplay") as Button
	if gun_button != null:
		var texture = gun_manager.get_gun_texture(gun_key)
		gun_button.icon = texture
		print("Updated fusion slot with gun: ", gun_key, " texture: ", texture)

func _update_fusion_info_labels() -> void:
	# update slot 1 info (firing style)
	if fusion_slot_1_gun != "" and gun_manager.guns.has(fusion_slot_1_gun):
		var gun = gun_manager.guns[fusion_slot_1_gun]
		var firing_mode_text = ""
		if gun.firing_mode == gun.FiringMode.SEMI_AUTO:
			firing_mode_text = "Semi-Auto"
		elif gun.firing_mode == gun.FiringMode.AUTO:
			firing_mode_text = "Auto"
		slot_1_info_label.text = firing_mode_text
	else:
		slot_1_info_label.text = ""
	
	# update slot 2 info (projectile type)
	if fusion_slot_2_gun != "" and gun_manager.guns.has(fusion_slot_2_gun):
		var gun = gun_manager.guns[fusion_slot_2_gun]
		var projectile_text = gun.projectile_type.capitalize()
		slot_2_info_label.text = projectile_text
	else:
		slot_2_info_label.text = ""

func _update_gun_box_highlight(gun_key: String, highlighted: bool) -> void:
	if gun_box_by_key.has(gun_key):
		var gun_box: Panel = gun_box_by_key[gun_key]
		var box_style: StyleBoxFlat = gun_box.get_theme_stylebox("panel").duplicate()
		if highlighted:
			box_style.border_color = white_color  # white when selected
			box_style.border_width_left = 3
			box_style.border_width_top = 3
			box_style.border_width_right = 3
			box_style.border_width_bottom = 3
		else:
			box_style.border_color = cyan_color  # cyan normally
			box_style.border_width_left = 2
			box_style.border_width_top = 2
			box_style.border_width_right = 2
			box_style.border_width_bottom = 2
		gun_box.add_theme_stylebox_override("panel", box_style)

func _check_fusion_preview() -> void:
	if fusion_slot_1_gun == "" or fusion_slot_2_gun == "":
		fusion_result_display.icon = null
		finalize_button.disabled = true
		fusion_preview_result = ""
		result_name_label.text = ""
		return
	
	# preview fusion result
	var result_key = gun_manager.get_fusion_result(fusion_slot_1_gun, fusion_slot_2_gun)
	
	if result_key == "":
		fusion_result_display.icon = null
		finalize_button.disabled = true
		fusion_preview_result = ""
		result_name_label.text = ""
	else:
		var result_texture = gun_manager.get_gun_texture(result_key)
		fusion_result_display.icon = result_texture
		finalize_button.disabled = false
		fusion_preview_result = result_key
		result_name_label.text = result_key.capitalize()

func _on_finalize_fusion() -> void:
	if fusion_slot_1_gun == "" or fusion_slot_2_gun == "":
		return
	
	# create fused gun
	var fusion_result_key: String = gun_manager.fuse_guns(fusion_slot_1_gun, fusion_slot_2_gun)
	
	# Clear fusion slots
	_update_gun_box_highlight(fusion_slot_1_gun, false)
	_update_gun_box_highlight(fusion_slot_2_gun, false)
	fusion_slot_1_gun = ""
	fusion_slot_2_gun = ""
	fusion_preview_result = ""
	
	_clear_fusion_slot(fusion_slot_1)
	_clear_fusion_slot(fusion_slot_2)
	
	fusion_result_display.icon = null
	finalize_button.disabled = true
	
	slot_1_info_label.text = ""
	slot_2_info_label.text = ""
	result_name_label.text = ""
	
	_refresh_guns()
