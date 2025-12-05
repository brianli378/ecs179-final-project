class_name MapController
extends Node2D

@onready var zone_1: ZoneTrigger = $Zone1
@onready var zone_2: ZoneTrigger = $Zone2
@onready var zone_3: ZoneTrigger = $Zone3

var pistol_enemy_spec = load("res://specs/pistol_enemy_spec.tres")
var machine_gun_enemy_spec = load("res://specs/machine_gun_enemy_spec.tres")
var sniper_enemy_spec = load("res://specs/sniper_enemy_spec.tres")
var shotgun_enemy_spec = load("res://specs/shotgun_enemy_spec.tres")
var rocket_launcher_enemy_spec = load("res://specs/rocket_launcher_enemy_spec.tres")
var strong_enemy_spec = load("res://specs/strong_enemy_spec.tres")

func _ready() -> void:
	# Confirm Map Ready
	print("Creating Enemy Locations and Specs")
	
	# Zone 1 Handling
	var spawnpoints_1 = []
	var enemies_1 = []
	
	spawnpoints_1.push_back(Vector2(1300, 400))
	spawnpoints_1.push_back(Vector2(1300, 1200))
	spawnpoints_1.push_back(Vector2(600, 1200))
	spawnpoints_1.push_back(Vector2(2200, 1200))
	enemies_1.push_back(sniper_enemy_spec)
	enemies_1.push_back(sniper_enemy_spec)
	enemies_1.push_back(sniper_enemy_spec)
	enemies_1.push_back(sniper_enemy_spec)
	zone_1.set_enemies(spawnpoints_1, enemies_1)
	
	# Zone 2 Handling
	var spawnpoints_2 = []
	var enemies_2 = []
	spawnpoints_2.push_back(Vector2(1200, 1400))
	spawnpoints_2.push_back(Vector2(400, 1400))
	spawnpoints_2.push_back(Vector2(1800, 400))
	spawnpoints_2.push_back(Vector2(1800, 2100))
	enemies_2.push_back(pistol_enemy_spec)
	enemies_2.push_back(pistol_enemy_spec)
	enemies_2.push_back(pistol_enemy_spec)
	enemies_2.push_back(pistol_enemy_spec)
	zone_2.set_enemies(spawnpoints_2, enemies_2)
	
	# Zone 3 Handling
	var spawnpoints_3 = []
	var enemies_3 = []
	spawnpoints_3.push_back(Vector2(1800, 400))
	spawnpoints_3.push_back(Vector2(1800, 1200))
	spawnpoints_3.push_back(Vector2(1000, 800))
	spawnpoints_3.push_back(Vector2(2700, 1200))
	enemies_3.push_back(pistol_enemy_spec)
	enemies_3.push_back(pistol_enemy_spec)
	enemies_3.push_back(pistol_enemy_spec)
	enemies_3.push_back(pistol_enemy_spec)
	zone_3.set_enemies(spawnpoints_3, enemies_3)
	
