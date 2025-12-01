class_name EnemyFactory
extends Node

func build(spec: EnemySpec):
	#TODO: need to add safety checks to make sure these exist
	var enemy_scene : PackedScene = load(spec.enemy_scene_path)
	var enemy : CharacterBody2D = enemy_scene.instantiate()
	enemy.initialize(spec)
	return enemy
