# res://scripts/fusion_guns/laser_gun.gd
class_name LaserGun
extends Gun

# overheat mechanic properties
var max_heat: float = 100.0
var current_heat: float = 0.0
var heat_per_shot: float = 10.0
var cooling_rate: float = 20.0  # heat units per second
var overheat_threshold: float = 100.0
var is_overheated: bool = false

# spread scaling with heat
var base_spread: float = 0.0
var max_heat_spread: float = 15.0  # max spread at full heat

# fire rate scaling (for laser machine gun)
var base_shot_delay: float = 0.1
var min_shot_delay: float = 0.05  # faster at high heat
var scales_fire_rate_with_heat: bool = false

# charging properties (for chargeable guns)
var is_chargeable: bool = false
var is_charging: bool = false
var charge_time: float = 0.0
var max_charge_time: float = 2.0

func _init() -> void:
	# default laser gun properties
	magazine_size = 999999  # "infinite" ammo
	starting_reserve = 0
	max_reserve = 0
	reload_time = 0.0
	projectile_type = "laser"

func get_heat_percentage() -> float:
	return current_heat / max_heat

func get_current_spread() -> float:
	var heat_ratio = get_heat_percentage()
	return base_spread + (max_heat_spread - base_spread) * heat_ratio

func get_current_shot_delay() -> float:
	if not scales_fire_rate_with_heat:
		return shot_delay
	
	var heat_ratio = get_heat_percentage()
	# as heat increases, shot delay decreases (faster fire rate)
	return base_shot_delay - (base_shot_delay - min_shot_delay) * heat_ratio

func add_heat(amount: float) -> void:
	current_heat = min(current_heat + amount, max_heat)
	if current_heat >= overheat_threshold:
		is_overheated = true

func cool_down(delta: float) -> void:
	if current_heat > 0:
		current_heat = max(current_heat - cooling_rate * delta, 0.0)
	
	# once cooled below threshold, no longer overheated
	if is_overheated and current_heat < overheat_threshold * 0.3:  # 30% threshold to resume
		is_overheated = false

func can_shoot() -> bool:
	return not is_overheated

# charging methods
func start_charging() -> void:
	if is_chargeable and not is_charging:
		is_charging = true
		charge_time = 0.0

func update_charge(delta: float) -> void:
	if is_charging:
		charge_time = min(charge_time + delta, max_charge_time)

func get_charge_percentage() -> float:
	if not is_chargeable:
		return 0.0
	return min(charge_time / max_charge_time, 1.0)

func release_charge() -> void:
	is_charging = false

func reset_charge() -> void:
	charge_time = 0.0
	is_charging = false

# override in subclasses for charge-specific behavior
func get_charged_damage_multiplier() -> float:
	return dmg_multiplier

func get_charged_heat() -> float:
	return heat_per_shot
