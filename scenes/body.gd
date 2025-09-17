extends Node2D
class_name Body
const BODY_SCENE = preload("res://scenes/body.tscn")

func primary_weapon_action(target_position) -> void:
	$Minigun.action()
	$Minigun.target_position = target_position

func primary_weapon_action_stop() -> void:
	$Minigun.stop_action()
