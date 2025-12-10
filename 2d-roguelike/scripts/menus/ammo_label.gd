extends Label

@export var gun_manager_path: NodePath
var gun_manager

func _ready() -> void:
	gun_manager = get_node(gun_manager_path)


func _process(_delta: float) -> void:
	var gun_keys = gun_manager.gun_keys
	var index = gun_manager.curr_gun_index
	var key = gun_keys[index]
	var mag = int(gun_manager.ammo_in_mag.get(key, 0))
	#var reserve = int(gun_manager.ammo_in_reserve.get(key, 0))
	
	text = "%d" % [mag]
