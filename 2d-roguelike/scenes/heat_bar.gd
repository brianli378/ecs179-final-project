extends Control

@export var gun_manager_path: NodePath

@onready var background: ColorRect = $Background
@onready var heat_fill: ColorRect = $HeatFill
@onready var heat_label: Label = $HeatLabel

var gun_manager

var cool_color: Color = Color(0.2, 0.9, 1.0)
var warm_color: Color = Color(1.0, 0.95, 0.0)
var hot_color: Color = Color(1.0, 0.4, 0.0)
var overheat_color: Color = Color(1.0, 0.0, 0.0)

func _ready() -> void:
	gun_manager = get_node(gun_manager_path)
	visible = false
	
	if background:
		background.color = Color(0.0, 0.0, 0.0, 0.7)
	
	if heat_fill:
		heat_fill.color = cool_color

func _process(_delta: float) -> void:
	if not gun_manager:
		return
	
	var is_laser_gun = gun_manager.curr_gun is LaserGun
	
	if is_laser_gun:
		visible = true
		_update_heat_bar()
	else:
		visible = false

func _update_heat_bar() -> void:
	var current_heat = gun_manager.get_current_heat()
	var max_heat = gun_manager.get_max_heat()
	var heat_percentage = current_heat / max_heat if max_heat > 0 else 0.0
	
	if heat_fill:
		var max_width = size.x - 4
		heat_fill.size.x = max_width * heat_percentage
		
		if gun_manager.is_gun_overheated():
			heat_fill.color = overheat_color
		elif heat_percentage > 0.75:
			heat_fill.color = hot_color
		elif heat_percentage > 0.4:
			var t = (heat_percentage - 0.4) / 0.35
			heat_fill.color = warm_color.lerp(hot_color, t)
		else:
			var t = heat_percentage / 0.4
			heat_fill.color = cool_color.lerp(warm_color, t)
	
	if heat_label:
		if gun_manager.is_gun_overheated():
			heat_label.text = "OVERHEATED!"
			heat_label.modulate = overheat_color
		else:
			heat_label.text = "HEAT: %d%%" % int(heat_percentage * 100)
			heat_label.modulate = Color.WHITE
