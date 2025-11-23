class_name BasicEnemy
extends CharacterBody2D

var health: int
var speed: float
var damage: float

var shooting_range: float
var 	_time: float = 0.0

#TODO: put this in the spec
var _furthest_leash: float = 600.0
var _closest_leash: float = 400.0

var _movement_speed: float = 300.0 # units per frame

#TODO: we could override shooting delay ourselves with one in this script
#var shooting_delay: float

var gun_manager: GunManager

@onready
var _player:Player = PlayerSingleton

func initialize(spec: EnemySpec):
	self.health = spec.health
	self.damage = spec.damage
	self.speed  = spec.speed
	self.gun_manager = spec.gun_manager.instantiate()
	
	gun_manager.position.x = 117.0
	
	self.shooting_range = spec.shooting_range
	
	# add gun manager to scene
	add_child(self.gun_manager)
	
	# make sure we ignore user inputs
	self.gun_manager.npc = true
	
func _ready():
	print("basic enemy ready")
	
func _process(_delta: float) -> void:
	look_at(_player.global_position)
	
	if health == 0:
		_handle_death()
		
func _handle_death() -> void:
	queue_free()

func _physics_process(_delta: float) -> void:
	_time += _delta

	# shooting logic
	if _distance_to_player() < shooting_range and _time >= 1.0:
		_time = 0.0
		gun_manager.shoot()
	
	# Calculate direction vector toward player
	var direction: Vector2 = (_player.global_position - global_position).normalized()
	var distance: float = _distance_to_player()

	if distance > _furthest_leash:
		# Move toward player
		velocity = direction * _movement_speed
	elif distance < _closest_leash:
		# Move away from player
		velocity = -direction * _movement_speed

	move_and_slide()


#TODO: take damage (similar to exercise 3)

func _distance_to_player() -> float:
	return self.global_position.distance_to(_player.global_position)

func _vector_to_player() -> Vector2:
	var x: float = _player.global_position.x - global_position.x
	var y: float = _player.global_position.y - global_position.y
	return Vector2(x,y)
