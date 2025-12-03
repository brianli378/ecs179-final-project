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
	var spawnpoints = []
	var enemies = []
	
	spawnpoints.push_back(Vector2(1300, 400))
	spawnpoints.push_back(Vector2(1300, 1200))
	spawnpoints.push_back(Vector2(600, 1200))
	spawnpoints.push_back(Vector2(2200, 1200))
	enemies.push_back(pistol_enemy_spec)
	enemies.push_back(pistol_enemy_spec)
	enemies.push_back(pistol_enemy_spec)
	enemies.push_back(pistol_enemy_spec)
	zone_1.set_enemies(spawnpoints, enemies)
	
	# Zone 2 Handling
	#spawnpoints.clear()
	#spawnpoints.push_back(Vector2())
	#spawnpoints.push_back(Vector2())
	#spawnpoints.push_back(Vector2())
	#spawnpoints.push_back(Vector2())
	#zone_2.set_enemies(spawnpoints, enemies)
	#
	## Zone 3 Handling
	#spawnpoints.clear()
	#spawnpoints.push_back(Vector2())
	#spawnpoints.push_back(Vector2())
	#spawnpoints.push_back(Vector2())
	#spawnpoints.push_back(Vector2())
	#zone_3.set_enemies(spawnpoints, enemies)
	
	#Clear Arrays
	#spawnpoints.clear()
	#enemies.clear()
	
