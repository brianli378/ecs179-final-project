extends Label

@export var gun_manager_path: NodePath
var gun_manager

func _ready() -> void:
	gun_manager = get_node(gun_manager_path)
	visible = false


func _process(_delta: float) -> void:
	visible = gun_manager.is_reloading
