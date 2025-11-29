extends Camera2D

@export var follow_speed: float = 7.0
@export var catchup_speed: float = 20.0
@export var leash_distance: float = 300.0 

const SHAKE_DURATION: float = 0.08
const SHAKE_STRENGTH: float = 30.0

var target: CharacterBody2D
var shake_time_remaining: float = 0.0
var shake_intensity: float = 0.0
var random_number_generator := RandomNumberGenerator.new()

func _ready() -> void:
	target = get_parent() as CharacterBody2D
	global_position = target.global_position


# when calling add_shake, you can change shake_multiplier for more or less camera shake.
func add_shake(shake_multiplier: float = 1.0) -> void:
	shake_time_remaining = SHAKE_DURATION
	shake_intensity = SHAKE_STRENGTH * shake_multiplier


func _physics_process(delta: float) -> void:
	if !target: return

	var target_position = target.global_position
	var is_moving = target.velocity.length() > 10.0
	var speed = follow_speed if is_moving else catchup_speed
	
	global_position = global_position.lerp(target_position, speed * delta)
	var distance = global_position.distance_to(target_position)
	
	if distance > leash_distance:
		var direction = global_position.direction_to(target_position)
		global_position = target_position - (direction * leash_distance)

	if shake_time_remaining > 0.0:
		shake_time_remaining = shake_time_remaining - delta
		var shake_progress = max(shake_time_remaining, 0.0) / SHAKE_DURATION
		var offset_x = random_number_generator.randf_range(-1.0, 1.0) * shake_intensity * shake_progress
		var offset_y = random_number_generator.randf_range(-1.0, 1.0) * shake_intensity * shake_progress
		offset = Vector2(offset_x, offset_y)
	else:
		offset = Vector2.ZERO
