class_name EnemyGunManager
extends Node2D

# Load the projectile types
var projectile_library = {
	"normal": preload("res://specs/projectiles/normal_projectile.tres"),
	"laser":  preload("res://specs/projectiles/laser_projectile.tres"),
	"rocket": preload("res://specs/projectiles/rocket_projectile.tres")
}

var curr_projectile_spec: ProjectileSpec = projectile_library["normal"]

var _time_since_last_shot: float = 0.0
var curr_gun: Gun = null

# we don't want to read inputs if the gun manager belongs to an npc
var npc: bool = false

@onready 
var shooting_sound: AudioStreamPlayer2D = $shooting_sound

@onready
var line_of_sight : EnemyLineOfSight = $EnemyLineOfSight

@onready 
var projectile_spawn: Node2D = $RotationPivot/ProjectileSpawn

@onready 
var _player:Player

@onready 
var enemy = get_parent().get_parent()

@onready 
var rotation_pivot: Node2D = $RotationPivot

func _ready() -> void:
	_player = get_tree().get_first_node_in_group("player")
	
	_set_gun_sprite()

func _set_gun_sprite() -> void:
	var parent : Node = get_parent().get_parent().get_parent()
	var gun_sprite : Sprite2D = Sprite2D.new()
	
	gun_sprite = parent.get_child(1)
	var sprite : Sprite2D = gun_sprite.duplicate()
	
	sprite.visible = true
	sprite.position.x -= 80
	
	get_child(0).add_child(sprite)


func _process(_delta: float) -> void:
	if _player == null:
		return
	_time_since_last_shot += _delta
	var direction: Vector2 = (_player.global_position - global_position).normalized()
	#look_at()

	if direction.x < 0:
		scale.x = -1  # Flip the gun vertically
		position.x = -abs(position.x)  # Move gun to the other side
	else:
		scale.x = 1  # Normal orientation
		position.x = abs(position.x)  # Move gun back to normal side

	rotation_pivot.look_at(_player.global_position)

func shoot() -> void:
	var multiplier = curr_gun.dmg_multiplier 
	var projectile_damage = curr_projectile_spec.damage
	var damage = projectile_damage * multiplier
	var base_direction: Vector2 = projectile_spawn.global_transform.x.normalized()
	var gun_sound = curr_gun.shoot_sound

	for i in range(curr_gun.projectile_count):
		var projectile = projectile_factory.create_projectile(curr_projectile_spec, damage)
		projectile.global_position = projectile_spawn.global_position
		projectile.rotation = projectile_spawn.global_rotation
		
		var angle_offset := 0.0
		if curr_gun.projectile_count > 1:
			var step := curr_gun.spread_angle / (curr_gun.projectile_count - 1)
			angle_offset = -curr_gun.spread_angle / 2.0 + (i * step)
		
		var direction := base_direction.rotated(deg_to_rad(angle_offset))
		projectile.linear_velocity = direction * curr_gun.projectile_speed
		
		shooting_sound.stream = gun_sound
		shooting_sound.play()
		
		#for child in projectile.get_children():
			#child.scale = curr_gun.projectile_scale
		
		self.get_tree().current_scene.add_child(projectile)
