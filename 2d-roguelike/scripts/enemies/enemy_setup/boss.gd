class_name Boss
extends Node2D

@onready
var _gun_manager: EnemyGunManager = $BossEnemy/Body/EnemyGunManager

@onready
var _enemy_char: CharacterBody2D = $BossEnemy

# set the gun for this enemy
func _ready() -> void:
	_gun_manager.setup_fusion_gun_for_boss()
	
func initialize(spec: EnemySpec):
	_enemy_char.initialize(spec)
