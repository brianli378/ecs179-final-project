class_name ShotgunEnemy
extends Node2D

@onready
var _gun_manager: EnemyGunManager = $BasicEnemy/Body/EnemyGunManager

@onready
var _enemy_char: CharacterBody2D = $BasicEnemy

# set the gun for this enemy
func _ready() -> void:
	_gun_manager.curr_gun = Shotgun.new()

func initialize(spec: EnemySpec):
	_enemy_char.initialize(spec)
