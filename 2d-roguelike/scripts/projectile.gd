class_name Projectile
extends RigidBody2D

#@onready var player: Player = $Player

var damage: float = 0.0

var npc_shot: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
	var timer = Timer.new()
	timer.wait_time = 3.0
	timer.one_shot = true
	timer.timeout.connect(_on_timeout)
	add_child(timer)
	timer.start()

func initialize(spec: ProjectileSpec, final_damage: float):
	self.damage = final_damage
	$Sprite2D.texture = spec.texture
	$Sprite2D.scale = spec.scale
	$CollisionShape2D.scale = spec.scale

func _on_body_entered(_body: Node) -> void:
	if npc_shot:
		if _body is Player:
			print(_body.health, "health start")
			print(damage, "damage")
			var scaled_damage = damage/4
			print(scaled_damage, "scaled")
			print(_body.health - scaled_damage, "health remaining")
			_body.health -= scaled_damage
			
			
	else:
		if _body is BasicEnemy:
			_body.health -= damage
			print(damage)
	if not _body is Projectile:
		queue_free()

func _on_timeout() -> void:
	queue_free()
