class_name EnemyGunManager
extends Node2D

@onready var projectile_spawn: Node2D = $ProjectileSpawn
@onready var _player:Player
@onready var enemy = get_parent().get_parent()
@onready var rotation_pivot: Node2D = $RotationPivot
var _projectile_scene = preload("res://scenes/projectile.tscn")
var _time_since_last_shot: float = 0.0
var facing_right = true
var curr_gun: Gun = null

# we don't want to read inputs if the gun manager belongs to an npc
var npc: bool = false

@onready
var line_of_sight : EnemyLineOfSight = $EnemyLineOfSight

func _ready() -> void:
	_player = get_tree().get_first_node_in_group("player")

func _process(_delta: float) -> void:
	_time_since_last_shot += _delta
	#look_at()
	

		
	
	if enemy.velocity.x < 0:
		scale.y = -1  # Flip the gun vertically
		position.x = -abs(position.x)  # Move gun to the other side
		facing_right = false
	else:
		scale.y = 1  # Normal orientation
		position.x = abs(position.x)  # Move gun back to normal side
		facing_right = true
	
	rotation_pivot.look_at(_player.global_position)
		
	if facing_right:
		rotation_pivot.scale.y = 1
		rotation_pivot.rotation = clamp(rotation_pivot.rotation, -1.5, 1.5)
	else:
		rotation_pivot.scale.y = -1
		var abs_rotation = abs(rotation_pivot.rotation)
		abs_rotation = clamp(abs_rotation, 1.5, 5)
		rotation_pivot.rotation = sign(rotation_pivot.rotation) * abs_rotation

func shoot() -> void:
	var projectile: Projectile = _projectile_scene.instantiate()
	projectile.global_position = projectile_spawn.global_position
	projectile.npc_shot = true
	
	var direction: Vector2 = projectile_spawn.global_transform.x.normalized()
	projectile.linear_velocity = direction * curr_gun.projectile_speed
	
	for child in projectile.get_children():
		child.scale = curr_gun.projectile_scale
	
	self.get_tree().current_scene.add_child(projectile)
