class_name Game
extends Node2D

# loading basic player spec:
var pistol_enemy_spec = load("res://specs/pistol_enemy_spec.tres")
var machine_gun_enemy_spec = load("res://specs/machine_gun_enemy_spec.tres")
var sniper_enemy_spec = load("res://specs/sniper_enemy_spec.tres")
var shotgun_enemy_spec = load("res://specs/shotgun_enemy_spec.tres")
var rocket_launcher_enemy_spec = load("res://specs/rocket_launcher_enemy_spec.tres")

var strong_enemy_spec = load("res://specs/strong_enemy_spec.tres")

@onready var spawn_point_1 = $StaticBody2D
@onready var spawn_point_2 = $StaticBody2D2
@onready var spawn_point_3 = $StaticBody2D3
@onready var spawn_point_4 = $StaticBody2D4
@onready var spawn_point_5 = $StaticBody2D5
@onready var spawn_point_6 = $StaticBody2D6

func _ready():
	var spawn_position1 = spawn_point_1.position
	var spawn_position2 = spawn_point_2.position
	var spawn_position3 = spawn_point_3.position
	var spawn_position4 = spawn_point_4.position
	var spawn_position5 = spawn_point_5.position
	var spawn_position6 = spawn_point_6.position
	
	spawn_point_1.queue_free()
	spawn_point_2.queue_free()
	spawn_point_3.queue_free()
	spawn_point_4.queue_free()
	spawn_point_5.queue_free()
	spawn_point_6.queue_free()
	
	var enemy1 = enemy_factory.build(shotgun_enemy_spec, self)
	var enemy2 = enemy_factory.build(shotgun_enemy_spec, self)
	var enemy3 = enemy_factory.build(shotgun_enemy_spec, self)
	
	"""
		# this is if we don't want to modify the basic specs 
		var spec_scaled = pistol_enemy_spec.duplicate()
		spec_scaled.damage = ...
		then pass spec_scaled instead of pistol_enemy_spec
	"""
	
	# these 2 will have scaled damage for basic
	var spec_scaled = shotgun_enemy_spec.duplicate()
	spec_scaled.damage *= 1.3
	
	var enemy4 = enemy_factory.build(spec_scaled, self)
	var enemy5 = enemy_factory.build(spec_scaled, self)
	
	# this will be new enemy
	enemy1.position = spawn_position1
	
	enemy2.position = spawn_position2
	
	enemy3.position = spawn_position3
	
	enemy4.position = spawn_position4
	
	enemy5.position = spawn_position5
