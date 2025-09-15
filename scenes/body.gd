extends Node2D

func primary_weapon_action(target_position) -> void:
	$Minigun.action()
	$Minigun.target_position = target_position

func primary_weapon_action_stop() -> void:
	$Minigun.stop_action()
