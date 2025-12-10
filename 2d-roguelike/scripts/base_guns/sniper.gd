class_name Sniper
extends Gun

var is_charging: bool = false
var charge_time: float = 0.0
var max_charge_time: float = 2.0
var min_charge_damage: float = 1.0
var max_charge_damage: float = 5.0

func _init() -> void:
	dmg_multiplier = 3.0
	projectile_speed = 2500
	shot_delay = 1.5
	projectile_scale = Vector2(0.08, 0.08)
	firing_mode = FiringMode.SEMI_AUTO
	projectile_count = 1
	projectile_type = "laser"
	spread_angle = 0.0
	shoot_sound = preload("res://assets/sounds/laser-sound.wav")
	magazine_size = 5
	starting_reserve = 20
	max_reserve = 50
	reload_time = 2.0

func get_charge_percentage() -> float:
	return min(charge_time / max_charge_time, 1.0)

func get_charged_damage_multiplier() -> float:
	var charge_ratio = get_charge_percentage()
	var charge_mult = lerp(min_charge_damage, max_charge_damage, charge_ratio)
	return dmg_multiplier * charge_mult
