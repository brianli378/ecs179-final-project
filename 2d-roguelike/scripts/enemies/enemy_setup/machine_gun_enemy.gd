class_name MachineGunEnemy
extends Node2D

@onready
var _gun_manager: EnemyGunManager = $BasicEnemy/Body/EnemyGunManager

@onready
var _enemy_char: CharacterBody2D = $BasicEnemy

# set the gun for this enemy
func _ready() -> void:
	_gun_manager.gun_keys = ['machine gun']
	_gun_manager.curr_gun = MachineGun.new()
	_gun_manager.curr_gun.shot_delay = 0.3
	
	_gun_manager.setup_gun()

func initialize(spec: EnemySpec):
	_enemy_char.initialize(spec)
