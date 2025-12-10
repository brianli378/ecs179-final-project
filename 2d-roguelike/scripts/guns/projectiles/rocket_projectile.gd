class_name RocketProjectile
extends Projectile

var PLAYER_DAMAGE_REDUCTION: float = 15
var explosion_radius: float = 350.0
	

func _ready() -> void:
	super._ready()

func _on_body_entered(_body: Node) -> void:
	if not _body is Projectile:
		_explode()
		queue_free()
	
	
func _explode() -> void:
	_show_explosion_visual()
	
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
			
		if not npc_shot and body is Enemy:
			body.health -= damage * damage_multiplier
		elif npc_shot and body is Player:
			#print(str(damage))
			#print(str((damage / PLAYER_DAMAGE_REDUCTION)))
			#print(str(damage_multiplier))
			#print("damage: " + str((damage / PLAYER_DAMAGE_REDUCTION) * damage_multiplier))
			#body.health -= (damage / PLAYER_DAMAGE_REDUCTION) * damage_multiplier
			var dmg := int(round((damage / PLAYER_DAMAGE_REDUCTION) * damage_multiplier))
			# tweak this variable
			body.health -= dmg
			

func _show_explosion_visual() -> void:
	var explosion_sprite = Sprite2D.new()
	explosion_sprite.global_position = global_position
	
	var size = int(explosion_radius * 2)
	var img = Image.create(size, size, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 0, 0))
	
	var center = explosion_radius
	var pixel_size = 8 # size of each explosion
	
	# draw pixelated circle
	for x in range(0, size, pixel_size):
		for y in range(0, size, pixel_size):
			var dx = x - center
			var dy = y - center
			var dist = sqrt(dx * dx + dy * dy)
			
			if dist <= explosion_radius:
				var color: Color
				var dist_ratio = dist / explosion_radius
				
				# color pallete
				if dist_ratio < 0.3:
					color = Color(1.0, 1.0, 0.8, 0.7)  # bright yellow-white center
				elif dist_ratio < 0.5:
					color = Color(1.0, 0.8, 0.2, 0.7)  # bright orange
				elif dist_ratio < 0.7:
					color = Color(1.0, 0.4, 0.0, 0.7)  # orange
				else:
					color = Color(0.8, 0.2, 0.0, 0.7)  # dark red edges
				
				# draw a pixel block
				for px in range(pixel_size):
					for py in range(pixel_size):
						var draw_x = x + px
						var draw_y = y + py
						if draw_x < size and draw_y < size:
							img.set_pixel(draw_x, draw_y, color)
	
	# disable texture filtering for crisp pixels
	var texture = ImageTexture.create_from_image(img)
	explosion_sprite.texture = texture
	explosion_sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	
	get_tree().current_scene.add_child(explosion_sprite)
	
	# animation with quick pop in and slower fade
	var tween = explosion_sprite.create_tween()
	tween.tween_property(explosion_sprite, "scale", Vector2(0.8, 0.8), 0.0)  # start smaller
	tween.tween_property(explosion_sprite, "scale", Vector2(1.2, 1.2), 0.15)  # pop out fast
	tween.parallel().tween_property(explosion_sprite, "modulate:a", 0.0, 0.3)  # fade
	tween.tween_callback(explosion_sprite.queue_free)
