class_name Projectile
extends RigidBody2D

#@onready var player: Player = $Player


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	

func _on_body_entered(_body: Node) -> void:
	if not _body is Projectile:
		queue_free()
