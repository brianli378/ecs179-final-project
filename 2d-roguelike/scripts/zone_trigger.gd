class_name ZoneTrigger
extends Area2D

func _ready() -> void:
	body_entered.connect(_on_zone_entered)
	return


func _on_zone_entered(player: Node2D) -> void:
	if player is Player:
		print("player.SPEED = ", player.SPEED)
	return
