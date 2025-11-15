class_name Game
extends Node2D

# loading basic player spec:
var basic_enemy_spec = load("res://specs/basic_enemy_spec.tres")

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
	
	"""
		# this is if we don't want to modify the basic specs 
		var spec_scaled = basic_enemy_spec.duplicate()
		spec_scaled.damage = ...
		then pass spec_scaled instead of basic_enemy_spec
	"""
	
	var enemy1 = enemy_factory.build(basic_enemy_spec)
	var enemy2 = enemy_factory.build(basic_enemy_spec)
	var enemy3 = enemy_factory.build(basic_enemy_spec)
	var enemy4 = enemy_factory.build(basic_enemy_spec)
	var enemy5 = enemy_factory.build(basic_enemy_spec)
	var enemy6 = enemy_factory.build(basic_enemy_spec)

	print("HERE")
	
	add_child(enemy1)
	enemy1.position = spawn_position1
	
	add_child(enemy2)
	enemy2.position = spawn_position2
	
	add_child(enemy3)
	enemy3.position = spawn_position3
	
	add_child(enemy4)
	enemy4.position = spawn_position4
	
	add_child(enemy5)
	enemy5.position = spawn_position5
	
	add_child(enemy6)
	enemy6.position = spawn_position6
	
	

	
	
	
	
	
	
	
	
