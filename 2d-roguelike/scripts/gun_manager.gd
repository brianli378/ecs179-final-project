class_name GunManager
extends Node2D

@onready var projectile_spawn: Node2D = $ProjectileSpawn
@onready var camera: Camera2D = get_parent().get_parent().get_node("Camera2D") as Camera2D

var projectile_scene = preload("res://scenes/projectile.tscn")

# Load the projectile types
var projectile_library = {
	"normal": preload("res://specs/projectiles/normal_projectile.tres"),
	"laser":  preload("res://specs/projectiles/laser_projectile.tres"),
	"rocket": preload("res://specs/projectiles/rocket_projectile.tres")
}
#var normal_projectile_spec = preload("res://specs/projectiles/normal_projectile.tres")
#var laser_projectile_spec = preload("res://specs/projectiles/laser_projectile.tres")
#var rocket_projectile_spec = preload("res://specs/projectiles/rocket_projectile.tres")

var _time_since_last_shot: float = 0.0

var guns: Array[Gun] = []
var curr_gun_index: int = 0
var curr_gun: Gun = null
# defaulted to normal projectile
var curr_projectile_spec: ProjectileSpec = projectile_library["laser"]

func _ready() -> void:
	guns = [
		Pistol.new(),
		MachineGun.new(),
		Sniper.new()
	]
	
	curr_gun = guns[curr_gun_index]
	

func _process(_delta: float) -> void:
	_time_since_last_shot += _delta
	
	if Input.is_action_just_pressed("switch_gun"):
		curr_gun_index = (curr_gun_index + 1) % guns.size()
		curr_gun = guns[curr_gun_index]
		
	# Add logic here for switching projectiles (Rytham will do this later)
		
	var should_shoot := false
	if curr_gun.firing_mode == Gun.FiringMode.SEMI_AUTO:
		should_shoot = Input.is_action_just_pressed("shoot")
	elif curr_gun.firing_mode == Gun.FiringMode.AUTO:
		should_shoot = Input.is_action_pressed("shoot")
	
	if should_shoot and _time_since_last_shot >= curr_gun.shot_delay:
		_shoot()
		_time_since_last_shot = 0.0


func _shoot() -> void:
	var projectile_damage = curr_projectile_spec.damage
	var multiplier = curr_gun.dmg_multiplier 
	var damage = projectile_damage * multiplier
	var projectile = projectile_factory.create_projectile(curr_projectile_spec, damage)
	
	projectile.global_position = projectile_spawn.global_position
	projectile.rotation = projectile_spawn.global_rotation
	var direction: Vector2 = projectile_spawn.global_transform.x.normalized()
	projectile.linear_velocity = direction * curr_gun.projectile_speed
	
	camera.add_shake(0.17)
	
	#for child in projectile.get_children():
		#child.scale = curr_gun.projectile_scale
	
	self.get_tree().current_scene.add_child(projectile)
