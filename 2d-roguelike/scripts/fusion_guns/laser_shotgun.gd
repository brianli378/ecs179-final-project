class_name LaserShotgun
extends LaserGun

var min_projectile_count: int = 3  # when fully charged
var max_projectile_count: int = 8  # when not charged

func _init() -> void:
	super._init()
	dmg_multiplier = 1.5
	projectile_speed = 1400
	shot_delay = 0.6
	projectile_scale = Vector2(0.04, 0.04)
	firing_mode = FiringMode.SEMI_AUTO
	projectile_count = 8
	spread_angle = 15.0
	shoot_sound = preload("res://assets/sounds/laser-sound.wav")
	
	# Overheat properties
	max_heat = 100.0
	heat_per_shot = 20.0
	cooling_rate = 20.0
	base_spread = 15.0
	max_heat_spread = 30.0
	
	# Enable charging
	is_chargeable = true
	max_charge_time = 1.5

func get_charged_projectile_count() -> int:
	var charge_ratio = get_charge_percentage()
	# More charge = fewer projectiles, tighter spread
	return int(lerp(float(max_projectile_count), float(min_projectile_count), charge_ratio))

func get_charged_spread() -> float:
	var charge_ratio = get_charge_percentage()
	var heat_spread = get_current_spread()
	# More charge = tighter spread
	return heat_spread * (1.0 - charge_ratio * 0.7)

func get_charged_damage_multiplier() -> float:
	var charge_ratio = get_charge_percentage()
	# More charge = more damage per projectile
	return dmg_multiplier * (1.0 + charge_ratio * 0.5)
