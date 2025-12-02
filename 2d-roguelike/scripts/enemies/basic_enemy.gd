## enemy navigation tutorial: https://casraf.dev/2024/09/pathfinding-guide-for-2d-top-view-tiles-in-godot-4-3/

class_name BasicEnemy
extends CharacterBody2D

var health: int
var speed: float
var damage: float

var shooting_range: float
var 	_time: float = 0.0

var _furthest_leash: float = 600.0
var _closest_leash: float = 400.0

var _movement_speed: float = 300.0 # units per frame

#TODO: we could override shooting delay ourselves with one in this script
#var shooting_delay: float

var enemy_los: EnemyLineOfSight = null

@onready
var gun_manager: EnemyGunManager = $Body/EnemyGunManager

@onready var nav: NavigationAgent2D = $NavigationAgent2D

@onready
var _player:Player

func initialize(spec: EnemySpec):
	self.health = spec.health
	self.damage = spec.damage
	self.speed  = spec.speed
	
	self.shooting_range = spec.shooting_range
	
	self._furthest_leash = spec.furthest_leash
	self._closest_leash = spec.closest_leash


func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(_player.position)


func set_movement_target(movement_target: Vector2):
	nav.target_position = movement_target


func _ready():
	print("BasicEnemy node:", self)
	print("Children:", get_children())
	print("gun_manager == null:", gun_manager == null)

	print("basic enemy ready")
		# make sure we ignore user inputs
	self.gun_manager.npc = true
	
	self.enemy_los = self.gun_manager.line_of_sight
	
	_player = get_tree().get_first_node_in_group("player")
	
	# navigation
	actor_setup.call_deferred()
	nav.velocity_computed.connect(_velocity_computed)


func _process(_delta: float) -> void:
	if _player == null:
		return
		
	# only look at the player if we are in the los
	if enemy_los.seeing_player:
		look_at(_player.global_position)
	
	if health == 0:
		_handle_death()


func _handle_death() -> void:
	queue_free()


func _physics_process(_delta: float) -> void:
	if _player == null:
		print("player null")
		return
	_time += _delta
	
	# shooting logic
	if enemy_los.seeing_player and _distance_to_player() < shooting_range and _time >= self.gun_manager.curr_gun.shot_delay:
		_time = 0.0
		gun_manager.shoot()
	
	
	_move_towards_player()


func _move_towards_player():
	# if we can see the player, do simple pathfinding
	if enemy_los.seeing_player:
		print("basic moving")
		print(position)
		# Calculate direction vector toward player
		var direction: Vector2 = (_player.global_position - global_position).normalized()
		var distance: float = _distance_to_player()

		if distance > _furthest_leash:
			# Move toward player
			velocity = direction * _movement_speed
		elif distance < _closest_leash:
			# Move away from player
			velocity = -direction * _movement_speed
	else:
		# smart pathfinding
		set_movement_target(_player.position)
		# If we're at the target, stop
		if nav.is_navigation_finished():
			print("at target")
			return

		# Get pathfinding information
		var current_agent_position: Vector2 = global_position
		var next_path_position: Vector2 = nav.get_next_path_position()

		# Calculate the new velocity
		var new_velocity = current_agent_position.direction_to(next_path_position) * speed

		# Set correct velocity
		if nav.avoidance_enabled:
			nav.set_velocity(new_velocity)
		else:
			_velocity_computed(new_velocity)

	# Do the movement
	move_and_slide()

func _velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity


func _distance_to_player() -> float:
	if _player == null:
		print("_player:", _player)
		print("type:", typeof(_player))

		return -1
	else:
		return self.global_position.distance_to(_player.global_position)


func _vector_to_player() -> Vector2:
	var x: float = _player.global_position.x - global_position.x
	var y: float = _player.global_position.y - global_position.y
	return Vector2(x,y)
