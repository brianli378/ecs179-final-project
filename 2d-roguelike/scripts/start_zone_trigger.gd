class_name StartZoneTrigger
extends Area2D

@onready var map_controller: MapController = $"../"

func _ready() -> void:
	body_entered.connect(_on_zone_entered)
	return


func _on_zone_entered(player: Node2D) -> void:
	if player is Player:
		map_controller.on_begin_zone.emit()
	return
