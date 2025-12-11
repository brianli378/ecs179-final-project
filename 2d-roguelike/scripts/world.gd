extends Node2D

var _menu:Resource = load("res://scenes/menus/main_menu.tscn")
var _menu_node:Node

var _death_menu:Resource = load("res://scenes/menus/death_menu.tscn")
var _death_menu_node:Node

var _pause_menu:Resource = load("res://scenes/menus/pause_menu.tscn")
var _pause_menu_node:Node

var _game:Resource = load("res://scenes/game.tscn")
var _game_node:Node

var _controls:Resource = load("res://scenes/menus/controls_menu.tscn")
var _controls_node:Node

var visibleNames:Array[String] = []

func start_menu() -> void:
	print("start_menu")
	_clear_scene_and_children()
	# instantisate the scene and add it as a child to the tree
	_menu_node = _menu.instantiate()
	add_child(_menu_node)


func controls_menu() -> void:
	print("controls menu")
	_clear_scene_and_children()
	# instantisate the scene and add it as a child to the tree
	_controls_node = _controls.instantiate()
	add_child(_controls_node)


func start_game() -> void:
	print("start_game")
	_clear_scene_and_children()
	_game_node = _game.instantiate()
	add_child(_game_node)


func death_menu() -> void:
	print("death_menu")
	_clear_scene_and_children()
	# instantisate the scene and add it as a child to the tree
	_death_menu_node = _death_menu.instantiate()
	add_child(_death_menu_node)


func pause_menu() -> void:
	print("pause menu")
	# instantisate the scene and add it as a child to the tree
	var root = get_tree().current_scene
	for child in root.get_children():
		if child.visible == true:
			visibleNames.append(child.name)
			child.visible = false
	
	for child in _game_node.get_children():
		if child.visible == true:
			visibleNames.append(child.name)
			child.visible = false
	_pause_menu_node = _pause_menu.instantiate()
	_pause_menu_node.visible = true
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var canvas = CanvasLayer.new()
	canvas.layer = 128

	add_child(canvas)
	canvas.add_child(_pause_menu_node)


func unpause() -> void:
	_pause_menu_node.queue_free()
	
	var root = get_tree().current_scene
	for child in root.get_children():
		if child.name in visibleNames:
			child.visible = true
			visibleNames.erase(child.name)
	
	for child in _game_node.get_children():
		if child.name in visibleNames:
			child.visible = true


func _ready():
	# clear leftover children from editor
	_clear_children()
	
	start_menu()


func _clear_scene_and_children()  -> void:
	_clear_children()
	
	var root = get_tree().current_scene
	for child in root.get_children():
		child.queue_free()


func _clear_children() -> void:
	for child in get_children():
		if child.name == "BackgroundMusic":
			continue
		child.queue_free()
