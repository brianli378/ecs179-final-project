extends Node2D

var _menu:Resource = load("res://scenes/MainMenu.tscn")
var _menu_node:Node

var _game:Resource = load("res://scenes/game.tscn")
var _game_node:Node
	
func start_menu() -> void:
	print("start_menu")
	_clear_scene()
	# instantisate the scene and add it as a child to the tree
	_menu_node = _menu.instantiate()
	add_child(_menu_node)

func start_game() -> void:
	print("start_game")
	_clear_scene()
	_game_node = _game.instantiate()
	add_child(_game_node)
	#TODO: when the player dies, we switch to that scene and free game node

func _process(_float) -> void:
	if Input.is_action_just_pressed("move_left"):
		start_menu()
	elif Input.is_action_just_pressed("move_right"):
		start_game()

func _ready():
	$MainMenu.queue_free()
	$Game.queue_free()
	start_menu()
	
func _clear_scene()  -> void:
	var root = get_tree().current_scene
	for child in root.get_children():
		child.queue_free()
