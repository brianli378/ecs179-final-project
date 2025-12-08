class_name RocketProjectile
extends Projectile

var PLAYER_DAMAGE_REDUCTION: float = 15

var explosion_radius: float = 200.0
	

func _on_body_entered(_body: Node) -> void:
	if not _body is Projectile:
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
	var hit_bodies = []
	
	for result in results:
		var body = result.collider
		
		if body in hit_bodies:
			continue
			
		hit_bodies.append(body)
		
		if body is Projectile or body is RocketProjectile:
			continue
		
		var distance = global_position.distance_to(body.global_position)
		
		var damage_multiplier = 1.0 - (distance / explosion_radius)
		damage_multiplier = clamp(damage_multiplier, 0.0, 1.0)
			
		if not npc_shot and body is BasicEnemy:
			body.health -= damage * damage_multiplier
		elif npc_shot and body is Player:
			#print(str(damage))
			#print(str((damage / PLAYER_DAMAGE_REDUCTION)))
			#print(str(damage_multiplier))
			#print("damage: " + str((damage / PLAYER_DAMAGE_REDUCTION) * damage_multiplier))
			body.health -= (damage / PLAYER_DAMAGE_REDUCTION) * damage_multiplier
