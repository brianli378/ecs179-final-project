extends Node

var heat_container: Control
var heat_bar: ProgressBar
var charge_bar: ProgressBar

@export var gun_manager_path: NodePath
@onready var gun_manager: Node = get_node_or_null(gun_manager_path)

func _ready() -> void:
	print("HEAT METER READY")
	# Try autoload detection if path fails
	if gun_manager == null:
		gun_manager = get_tree().get_root().find_child("GunManager", true, false)
		if gun_manager == null:
			push_warning("HeatMeter: GunManager not found!")
			return

	# Find CanvasLayer
	var canvas_layer := get_tree().get_root().find_child("CanvasLayer", true, false)
	if canvas_layer == null:
		push_warning("HeatMeter: No CanvasLayer found!")
		return

	_create_ui(canvas_layer)


func _create_ui(parent: Node) -> void:
	# -----------------------------
	# Container
	# -----------------------------
	heat_container = Control.new()
	heat_container.name = "HeatMeter"

	# Anchor to TOP-RIGHT
	heat_container.anchor_left = 1.0
	heat_container.anchor_right = 1.0
	heat_container.anchor_top = 0.0
	heat_container.anchor_bottom = 0.0

	# Position offsets
	heat_container.offset_left = -220
	heat_container.offset_right = 0
	heat_container.offset_top = 20
	heat_container.offset_bottom = 80

	parent.add_child(heat_container)

	# -----------------------------
	# Heat BAR
	# -----------------------------
	heat_bar = ProgressBar.new()
	heat_bar.name = "HeatBar"
	heat_bar.position = Vector2(0, 0)
	heat_bar.size = Vector2(200, 25)
	heat_bar.min_value = 0
	heat_bar.max_value = 100
	heat_bar.value = 50             # visible test value
	heat_bar.show_percentage = true
	var debug_box := ColorRect.new()
	debug_box.color = Color(1, 0, 0, 0.8) # BRIGHT RED
	debug_box.size = Vector2(400, 200)
	debug_box.position = Vector2(-400, 0) # sticks out from right edge
	heat_container.add_child(debug_box)
	_make_progressbar_visible(heat_bar, Color(1, 0, 0))
	heat_container.add_child(heat_bar)

	# -----------------------------
	# Charge BAR
	# -----------------------------
	charge_bar = ProgressBar.new()
	charge_bar.name = "ChargeBar"
	charge_bar.position = Vector2(0, 30)
	charge_bar.size = Vector2(200, 25)
	charge_bar.min_value = 0
	charge_bar.max_value = 100
	charge_bar.value = 75            # visible test value
	charge_bar.show_percentage = true

	_make_progressbar_visible(charge_bar, Color(1, 1, 1))
	heat_container.add_child(charge_bar)


# ---------------------------------------------------
# FORCES the bar to be visible even with custom theme
# ---------------------------------------------------
func _make_progressbar_visible(bar: ProgressBar, fill_color: Color) -> void:
	# Text
	bar.add_theme_color_override("font_color", Color.WHITE)
	bar.add_theme_color_override("font_outline_color", Color.BLACK)
	bar.add_theme_constant_override("outline_size", 2)

	# Background
	var bg := StyleBoxFlat.new()
	bg.bg_color = Color(0.1, 0.1, 0.1, 1)
	bar.add_theme_stylebox_override("background", bg)

	# Fill
	var fill := StyleBoxFlat.new()
	fill.bg_color = fill_color
	bar.add_theme_stylebox_override("fill", fill)


# ---------------------------------------------------
# Runtime updating logic
# ---------------------------------------------------
func _process(_delta: float) -> void:
	# Remove test values and drive from gun_manager
	if gun_manager == null:
		return

	heat_container.visible = true  # force visible during debugging

	if gun_manager.has_method("get_current_heat"):
		var curr = gun_manager.get_current_heat()
		var maxh = gun_manager.get_max_heat()
		if maxh > 0:
			heat_bar.value = (curr / maxh) * 100.0

	if gun_manager.has_method("get_charge_percentage"):
		var pct = gun_manager.get_charge_percentage()
		charge_bar.value = pct * 100.0
