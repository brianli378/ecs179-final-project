extends Node2D

var _menu:Resource = load("res://scenes/MainMenu.tscn")
var _menu_node:Node

var _death_menu:Resource = load("res://scenes/death_menu.tscn")
var _death_menu_node:Node

var _pause_menu:Resource = load("res://scenes/pause_menu.tscn")
var _pause_menu_node:Node

var _game:Resource = load("res://scenes/game.tscn")
var _game_node:Node

#var _all_nodes:Array[Node] = [_menu_node, _death_menu_node, _game_node]
	
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

func death_menu() -> void:
	print("death_menu")
	_clear_scene()
	# instantisate the scene and add it as a child to the tree
	_death_menu_node = _death_menu.instantiate()
	add_child(_death_menu_node)
	
func pause_menu() -> void:
	print("pause menu")
	# instantisate the scene and add it as a child to the tree
	_pause_menu_node = _pause_menu.instantiate()
	add_child(_pause_menu_node)

func unpause() -> void:
	_pause_menu_node.queue_free()

func _ready():
	$MainMenu.queue_free()
	$Game.queue_free()
	$DeathMenu.queue_free()
	$PauseMenu.queue_free()
	start_menu()
	
func _clear_scene()  -> void:
	#TODO: for some reason, this loop doesn't work, but the if statements do
	#for node in _all_nodes:
	#	if node != null:
	#		node.queue_free()
	if _death_menu_node != null:
		_death_menu_node.queue_free()
	if _menu_node != null:
		_menu_node.queue_free()
	if _game_node != null:
		_game_node.queue_free()
	if _pause_menu_node != null:
		_pause_menu_node.queue_free()
		
	var root = get_tree().current_scene
	for child in root.get_children():
		child.queue_free()
