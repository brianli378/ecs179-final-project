class_name RocketProjectile
extends RigidBody2D

var explosion_radius: float = 200.0
var max_damage: float = 100.0


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	

func _on_body_entered(_body: Node) -> void:
	if not _body is Projectile and not _body is RocketProjectile:
		_explode()
		queue_free()
	
	
func _explode() -> void:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	
	var shape = CircleShape2D.new()
	shape.radius = explosion_radius
	query.shape = shape
	query.transform = global_transform
	query.collide_with_areas = true
	query.collide_with_bodies = true
	
	var results = space_state.intersect_shape(query)
	
	for result in results:
		var body = result.collider
		
		if body is Projectile or body is RocketProjectile:
			continue
		
		var distance = global_position.distance_to(body.global_position)
		
		var damage_multiplier = 1.0 - (distance / explosion_radius)
		damage_multiplier = clamp(damage_multiplier, 0.0, 1.0)
		var damage = max_damage * damage_multiplier
		
		if body.has_method("take_damage"):
			body.take_damage(damage)
