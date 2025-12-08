class_name MapController
extends Node2D

@onready var safe_zone: StartZoneTrigger = $StartZone
@onready var zone_1: EnemyZoneTrigger = $Zone1
@onready var zone_2: EnemyZoneTrigger = $Zone2
@onready var zone_3: EnemyZoneTrigger = $Zone3
@onready var boss_zone: EnemyZoneTrigger = $BossZone
@onready var world: World = $"/root/World"
@onready var game: Game = $"../"

var enemy_emitter = preload("res://scripts/enemies/basic_enemy.gd")
var pistol_enemy_spec = load("res://specs/pistol_enemy_spec.tres")
var machine_gun_enemy_spec = load("res://specs/machine_gun_enemy_spec.tres")
var sniper_enemy_spec = load("res://specs/sniper_enemy_spec.tres")
var shotgun_enemy_spec = load("res://specs/shotgun_enemy_spec.tres")
var rocket_launcher_enemy_spec = load("res://specs/rocket_launcher_enemy_spec.tres")
var boss_enemy_spec = load("res://specs/boss_enemy_spec.tres")

var BASE_ENEMIES = [
		pistol_enemy_spec, 
		machine_gun_enemy_spec, 
		sniper_enemy_spec, 
		shotgun_enemy_spec, 
		rocket_launcher_enemy_spec,
]

# Base Spawnpoint for Player
const SPAWNPOINT_BASE_P = Vector2(499, 194)

# Zone 1 Spawnpoints
const SPAWNPOINTS_1 = [
		Vector2(1300, 400),
		Vector2(1300, 1200),
		Vector2(600, 1200),
		Vector2(2200, 1200),
]

# Zone 2 Spawnpoints
const SPAWNPOINTS_2 = [
		Vector2(1200, 1400),
		Vector2(400, 1400),
		Vector2(1800, 400),
		Vector2(1800, 2100),
]

# Zone 3 Spawnpoints
const SPAWNPOINTS_3 = [
		Vector2(1800, 400),
		Vector2(1800, 1200),
		Vector2(1000, 800),
		Vector2(2700, 1200),
]

# Boss Zone Spawnpoints
const SPAWNPOINT_BOSS_B = [Vector2(1120, 560)]
const SPAWNPOINT_BOSS_P = Vector2(1120, 1680)

# Safe Zone Spawnpoints
const SPAWNPOINT_SAFE_P = Vector2(-200, 500)

var num_enemies = 0;

enum Stage {
	SAFE,
	BASE,
	BOSS
}

var stage;
var current_round: int = 1

signal on_begin_zone

signal enemy_death

func _ready() -> void:
	on_begin_zone.connect(_on_begin_zone)
	game.enemy_death.connect(_on_enemy_death)
	stage = Stage.SAFE

func _get_scaled_spec(old_spec: EnemySpec) -> EnemySpec:
	var new_spec = old_spec.duplicate()
	
	if current_round == 1:
		return new_spec
		
	# health scaler:
	var health_multiplier = 1.0 + (0.15 * sqrt(current_round))
	# damage scaler
	var dmg_multiplier = 1.0 + (0.10 * (log(current_round) / log(2)))

	new_spec.health = int(old_spec.health * health_multiplier)
	new_spec.damage = old_spec.damage * dmg_multiplier
	
	return new_spec

func _set_base_zones(difficulty: float) -> void:
	num_enemies = 0
	
	#Zone 1 Handling
	var enemies_1 = []
	for i in range(4):
		var rand_index = randi_range(0, 4)
		var old_spec = BASE_ENEMIES[rand_index]
		enemies_1.push_back(_get_scaled_spec(old_spec))
	num_enemies += enemies_1.size();
	zone_1.set_enemies(SPAWNPOINTS_1.duplicate(), enemies_1)
	
	#Zone 2 Handling
	var enemies_2 = []
	for i in range(4):
		var rand_index = randi_range(0, 4)
		var old_spec = BASE_ENEMIES[rand_index]
		enemies_2.push_back(_get_scaled_spec(old_spec))
	num_enemies += enemies_2.size();
	zone_2.set_enemies(SPAWNPOINTS_2.duplicate(), enemies_2)
	
	#Zone 3 Handling
	var enemies_3 = []
	for i in range(4):
		var rand_index = randi_range(0, 4)
		var old_spec = BASE_ENEMIES[rand_index]
		enemies_3.push_back(_get_scaled_spec(old_spec))
	num_enemies += enemies_3.size();
	zone_3.set_enemies(SPAWNPOINTS_3.duplicate(), enemies_3)
	
	return


func _set_boss_zone(difficulty: float) -> void:
	var scaled_boss = _get_scaled_spec(boss_enemy_spec)
	var enemies = [scaled_boss]
	boss_zone.set_enemies(SPAWNPOINT_BOSS_B.duplicate(), enemies)
	num_enemies += 1
	return


func _on_enemy_death() -> void:
	num_enemies -= 1
	#print("Enemy Died. Remaining: ", num_enemies)
	
	if num_enemies <= 0:
		match stage:
			Stage.BASE:
				stage = Stage.BOSS
				_set_boss_zone(0.0)
				game.on_player_teleport.emit(global_position + boss_zone.position + SPAWNPOINT_BOSS_P)
			Stage.BOSS:
				# add guns
				stage = Stage.SAFE
				current_round += 1
				game.on_player_teleport.emit(global_position + safe_zone.position + SPAWNPOINT_SAFE_P)

func _on_begin_zone() -> void:
	stage = Stage.BASE
	_set_base_zones(0)
	game.on_player_teleport.emit(global_position + zone_1.position + SPAWNPOINT_BASE_P)
	
