class_name ProjectileSpec
extends Resource

enum ProjectileType { NORMAL, LASER, ROCKET }

@export var texture: Texture2D
@export var scale: Vector2
@export var damage: float
@export var type: ProjectileType
