class_name LaserShotgun
extends LaserGun

var min_projectile_count: int = 3  # when fully charged
var max_projectile_count: int = 8  # when not charged

func _init() -> void:
	super._init()
	dmg_multiplier = 1.2
	projectile_speed = 1200
	shot_delay = 0.7
	projectile_scale = Vector2(0.04, 0.04)
	firing_mode = FiringMode.SEMI_AUTO
	projectile_count = 6
	shoot_sound = preload("res://assets/sounds/laser-sound.wav")
	
	max_heat = 100.0
	heat_per_shot = 20.0
	cooling_rate = 20.0
	base_spread = 30.0        # Base shotgun spread (not charged, no heat)
	max_heat_spread = 50.0    # Maximum spread when overheated
	
	# Enable charging
	is_chargeable = true
	max_charge_time = 1.5

func get_charged_projectile_count() -> int:
	var charge_ratio = get_charge_percentage()
	# More charge = fewer projectiles, tighter spread
	return int(lerp(float(max_projectile_count), float(min_projectile_count), charge_ratio))

func get_current_spread() -> float:
	# Call parent to get heat-based spread first
	var heat_spread = super.get_current_spread()
	
	# Then apply charge modifier
	var charge_ratio = get_charge_percentage()
	# More charge = tighter spread (reduce by up to 70%)
	return heat_spread * (1.0 - charge_ratio * 0.7)

func get_charged_damage_multiplier() -> float:
	var charge_ratio = get_charge_percentage()
	# More charge = more damage per projectile
	return dmg_multiplier * (1.0 + charge_ratio * 0.5)
