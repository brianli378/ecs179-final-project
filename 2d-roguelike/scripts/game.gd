class_name Game
extends Node2D

# loading basic player spec:
var pistol_enemy_spec = load("res://specs/pistol_enemy_spec.tres")
var machine_gun_enemy_spec = load("res://specs/machine_gun_enemy_spec.tres")
var sniper_enemy_spec = load("res://specs/sniper_enemy_spec.tres")
var shotgun_enemy_spec = load("res://specs/shotgun_enemy_spec.tres")
var rocket_launcher_enemy_spec = load("res://specs/rocket_launcher_enemy_spec.tres")

@onready var spawn_point_1 = $StaticBody2D
@onready var spawn_point_2 = $StaticBody2D2
@onready var spawn_point_3 = $StaticBody2D3
@onready var spawn_point_4 = $StaticBody2D4
@onready var spawn_point_5 = $StaticBody2D5
@onready var spawn_point_6 = $StaticBody2D6
@onready var player: Player = $Player
@onready var map_controller: MapController = $Maps

signal on_player_teleport(position: Vector2)
signal enemy_death

func _ready():
	on_player_teleport.connect(_on_player_teleport)
	

func _on_player_teleport(pos: Vector2) -> void:
	player.global_position = pos


func _on_enemy_death() -> void:
	enemy_death.emit()
