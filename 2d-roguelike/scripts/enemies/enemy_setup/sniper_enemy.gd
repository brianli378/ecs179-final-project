class_name SniperEnemy
extends Node2D

@onready
var _gun_manager: EnemyGunManager = $BasicEnemy/Body/EnemyGunManager

@onready
var _enemy_char: CharacterBody2D = $BasicEnemy

var projectile_library = {
	"normal": preload("res://specs/projectiles/normal_projectile.tres"),
	"laser":  preload("res://specs/projectiles/laser_projectile.tres"),
	"rocket": preload("res://specs/projectiles/rocket_projectile.tres")
}

# set the gun for this enemy
func _ready() -> void:
	_gun_manager.curr_gun = Sniper.new()
	_gun_manager.curr_projectile_spec = projectile_library["laser"]

func initialize(spec: EnemySpec):
	_enemy_char.initialize(spec)
