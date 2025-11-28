class_name GunManager
extends Node2D

@onready var projectile_spawn: Node2D = $ProjectileSpawn
@onready var camera: Camera2D = get_parent().get_parent().get_node("Camera2D") as Camera2D

var _projectile_scene = preload("res://scenes/projectile.tscn")
var _rocket_projectile_scene = preload("res://scenes/rocket_projectile.tscn")
var _time_since_last_shot: float = 0.0

var guns: Array[Gun] = []
var curr_gun_index: int = 0
var curr_gun: Gun = null


func _ready() -> void:
	guns = [
		Pistol.new(),
		MachineGun.new(),
		Sniper.new(),
		Shotgun.new(),
		RocketLauncher.new()
	]
	
	curr_gun = guns[curr_gun_index]
	

func _process(_delta: float) -> void:
	_time_since_last_shot += _delta
	
	if Input.is_action_just_pressed("switch_gun"):
		curr_gun_index = (curr_gun_index + 1) % guns.size()
		curr_gun = guns[curr_gun_index]
		
	var should_shoot := false
	if curr_gun.firing_mode == Gun.FiringMode.SEMI_AUTO:
		should_shoot = Input.is_action_just_pressed("shoot")
	elif curr_gun.firing_mode == Gun.FiringMode.AUTO:
		should_shoot = Input.is_action_pressed("shoot")
	
	if should_shoot and _time_since_last_shot >= curr_gun.shot_delay:
		_shoot()
		_time_since_last_shot = 0.0


func _shoot() -> void:
	var base_direction := projectile_spawn.global_transform.x.normalized()
	
	for i in range(curr_gun.projectile_count):
		var projectile
		if curr_gun is RocketLauncher:
			projectile = _rocket_projectile_scene.instantiate()
			projectile.max_damage = curr_gun.damage
			projectile.explosion_radius = curr_gun.explosion_radius
		else:
			projectile = _projectile_scene.instantiate()
		projectile.global_position = projectile_spawn.global_position
		
		var angle_offset := 0.0
		if curr_gun.projectile_count > 1:
			var step := curr_gun.spread_angle / (curr_gun.projectile_count - 1)
			angle_offset = -curr_gun.spread_angle / 2.0 + (i * step)
		
		var direction := base_direction.rotated(deg_to_rad(angle_offset))
		projectile.linear_velocity = direction * curr_gun.projectile_speed
		
		for child in projectile.get_children():
			child.scale = curr_gun.projectile_scale
		
		self.get_tree().current_scene.add_child(projectile)
	
	camera.add_shake(0.17)
