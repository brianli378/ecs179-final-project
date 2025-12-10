class_name EnemyFactory
extends Node

func build(spec: EnemySpec, world_node: Node) -> Node2D:
	#TODO: need to add safety checks to make sure these exist
	var enemy_scene : PackedScene = load(spec.enemy_scene_path)
	var enemy : Node2D = enemy_scene.instantiate()
	world_node.add_child(enemy)
	enemy.initialize(spec)
	enemy._enemy_char.enemy_death.connect(world_node._on_enemy_death)
	return enemy
