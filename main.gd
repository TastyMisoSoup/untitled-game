extends Node2D
class_name Main

const CROSSHAIR = preload("res://assets/icons/cursor.png")
var map: PackedScene = Lobby.map

func _init() -> void:
	var map_inst = map.instantiate()
	add_child(map_inst)
	Input.set_custom_mouse_cursor(CROSSHAIR,Input.CursorShape.CURSOR_ARROW,Vector2(16,16))
	
