extends Node2D

const CROSSHAIR = preload("res://assets/icons/cursor.png")

func _process(_delta: float) -> void:
	pass

func _ready() -> void:
	Input.set_custom_mouse_cursor(CROSSHAIR,Input.CursorShape.CURSOR_ARROW,Vector2(16,16))
	pass
