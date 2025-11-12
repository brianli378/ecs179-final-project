class_name Gun
extends Node2D

@export var damage: int = 5
@export var projectile_speed: int = 1000
@export var shot_delay: float = 0.0

@onready var projectile_spawn: Node2D = $ProjectileSpawn
#@onready var player: CharacterBody2D = $Player

var _projectile_scene = preload("res://scenes/projectile.tscn")
var _time_since_last_shot: float = 0.0


func _process(_delta: float) -> void:
	_time_since_last_shot += _delta
	
	if Input.is_action_just_pressed("shoot") and _time_since_last_shot >= shot_delay:
		var projectile: Projectile = _projectile_scene.instantiate()
		projectile.global_position = projectile_spawn.global_position
		
		var direction: Vector2 = projectile_spawn.global_transform.x.normalized()
		projectile.linear_velocity = direction * projectile_speed
		
		self.get_tree().current_scene.add_child(projectile)
		
		_time_since_last_shot = 0.0
