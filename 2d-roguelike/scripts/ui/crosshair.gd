class_name MyCrosshair
extends Node2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var gun_manager_path: NodePath

var is_reloading := false
var was_reloading := false
var gun_manager

const BASE_RELOAD_ANIMATION_DURATION: float = 3.4

func _ready() -> void:
	gun_manager = get_node(gun_manager_path)
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	anim.play("idle")
	

func _process(_delta: float) -> void:
	
	#print(gun_manager)
	global_position = get_global_mouse_position()
	
	if gun_manager and gun_manager.is_reloading and not was_reloading:
		start_reload_animation()
		was_reloading = true
	elif gun_manager and not gun_manager.is_reloading and was_reloading:
		stop_reload_animation()
		was_reloading = false
	
func start_reload_animation() -> void:
	#print(gun_manager.reload_time)
	var speed = BASE_RELOAD_ANIMATION_DURATION / gun_manager.reload_time
	anim.speed_scale = speed
	anim.play("reload")
	

func stop_reload_animation() -> void:
	anim.play("idle")

func _exit_tree() -> void:

	print(gun_manager)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
