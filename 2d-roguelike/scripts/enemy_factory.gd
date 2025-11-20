class_name EnemyFactory
extends Node

func build(spec: EnemySpec):
	# need to add safety checks to make sure these exist
	var enemy_scene = load(spec.enemy_scene_path)
	var enemy = enemy_scene.instantiate()
	enemy.initialize(spec)
	return enemy
	
