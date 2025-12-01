class_name Shiper
extends Node2D

enum FiringMode { SEMI_AUTO, AUTO }

@export var dmg_multiplier: float = 1
@export var projectile_speed: int = 1000
@export var shot_delay: float = 0.0
@export var projectile_scale: Vector2 = Vector2.ONE
@export var firing_mode: FiringMode = FiringMode.SEMI_AUTO
@export var projectile_count: int = 1
@export var spread_angle: float = 0.0
@export var explosion_radius: float = 0.0
@export var projectile_type: String = "normal"
