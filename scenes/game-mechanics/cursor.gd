extends Node2D
class_name Cursor

func _process(delta: float) -> void:
	position = get_global_mouse_position()
