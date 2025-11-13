class_name Player
extends CharacterBody2D

# This is the root world scene we can use to switch menus
var _world:Node2D = World

var speed = 700.0

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	

func _physics_process(_delta: float) -> void:
	var move_direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	
	if move_direction != Vector2.ZERO:
		velocity = speed * move_direction.normalized()
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	
	if Input.is_action_just_pressed("ui_accept"):
		_world.death_menu()
	
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		_world.pause_menu()
		
	move_and_slide()
