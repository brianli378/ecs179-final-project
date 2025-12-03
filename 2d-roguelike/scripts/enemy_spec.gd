# extends resource: https://docs.godotengine.org/en/stable/tutorials/scripting/resources.html
class_name EnemySpec
extends Resource

# scene path for enemy
@export var enemy_scene_path: String

# enemy stats
@export var health: int
@export var damage: float
@export var speed: float

@export var shooting_range: float
@export var gun_manager: PackedScene

@export var furthest_leash: float
@export var closest_leash: float
