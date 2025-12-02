class_name Projectile
extends RigidBody2D

#@onready var player: Player = $Player

var damage: float = 0.0

var npc_shot: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func initialize(spec: ProjectileSpec, final_damage: float):
	self.damage = final_damage
	$Sprite2D.texture = spec.texture
	$Sprite2D.scale = spec.scale
	$CollisionShape2D.scale = spec.scale

func _on_body_entered(_body: Node) -> void:
	#TODO: get damage from projectile
	if npc_shot:
		if _body is Player:
			_body.health -= 1
	else:
		if _body is BasicEnemy:
			_body.health -= 50
	if not _body is Projectile:
		queue_free()
