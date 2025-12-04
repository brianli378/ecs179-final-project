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
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D


@onready
var _player:Player

func initialize(spec: EnemySpec):
	self.health = spec.health
	self.damage = spec.damage
	self.speed  = spec.speed
	
	self.shooting_range = spec.shooting_range
	
	self._furthest_leash = spec.furthest_leash
	self._closest_leash = spec.closest_leash

func _ready():
	print("BasicEnemy node:", self)
	print("Children:", get_children())
	print("gun_manager == null:", gun_manager == null)

	print("basic enemy ready")
		# make sure we ignore user inputs
	self.gun_manager.npc = true
	
	self.enemy_los = self.gun_manager.line_of_sight
	
	_player = get_tree().get_first_node_in_group("player")

func _process(_delta: float) -> void:
	if _player == null:
		return
		
	
		
	# only look at the player if we are in the los
	
	if enemy_los.seeing_player:
		pass
		#anim.play("default")
		#look_at(_player.global_position)
	#print(health)
	if health <= 0:
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
	
	# Calculate direction vector toward player
	var direction: Vector2 = (_player.global_position - global_position).normalized()
	var distance: float = _distance_to_player()
	

	if distance > _furthest_leash:
		#print("walk")
		# Move toward player
		velocity = direction * _movement_speed
	elif distance < _closest_leash:
		# Move away from player
		velocity = -direction * _movement_speed
	if velocity.x < 0:
		anim.play("walk_left")
	elif velocity.x > 0 :
		anim.play("walk_right")
	else:
		anim.play("default")
		
	move_and_slide()


#TODO: take damage (similar to exercise 3)

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
