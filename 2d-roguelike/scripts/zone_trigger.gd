class_name ZoneTrigger
extends Area2D

var _spawnpoints := []
var _enemy_specs := []
var _active_enemies := []
var triggered := false
@onready var world_node = $"/root/World"



func _ready() -> void:
	body_entered.connect(_on_zone_entered)
	return

func set_enemies(spawn_arr: Array, enemy_arr: Array) -> void:
	if spawn_arr.size() == enemy_arr.size():
		_spawnpoints = spawn_arr
		_enemy_specs = enemy_arr
	return


func _on_zone_entered(player: Node2D) -> void:
	if player is Player and not triggered:
		triggered = true;
		call_deferred("spawn_enemies")
		print("Entered New Zone, Spawning Enemies!")
	return

func spawn_enemies() -> void:
	while _spawnpoints.size() > 0:
		var enemy_spec = _enemy_specs.pop_front()
		var enemy = enemy_factory.build(enemy_spec, world_node)
		enemy.global_position = self.position + _spawnpoints.pop_front()
	return
